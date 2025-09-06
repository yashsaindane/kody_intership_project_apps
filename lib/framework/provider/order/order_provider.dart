import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../repository/order/model/hive_order_model.dart';
import '../auth/auth_provider.dart';

class OrderNotifier extends StateNotifier<List<Order>> {
  final Ref ref; // used for reading providers

  // Constructor of OrderNotifier, initializing with an empty order list
  OrderNotifier(this.ref) : super([]);
  static const boxName =
      'ordersBox'; // This is the Box name in Hive for storing orders data

  // Load all orders for the current user which is filtered using email
  Future<void> loadOrders() async {
    final box = await Hive.openBox<Order>(
      boxName,
    ); // Open the Hive box for orders
    final userEmail =
        ref.read(authProvider)?.email ??
        "guest"; // Get user email or default to "guest"

    // Her orders are filter using userEmail and update state with the filtered list
    state = box.values.where((order) => order.userEmail == userEmail).toList();
  }

  // Add a new order to the Hive box and reload the orders
  Future<void> addOrder(Order order) async {
    final box = await Hive.openBox<Order>(boxName);
    await box.add(order); // Add the new order to the box
    await loadOrders(); // Reload the orders after adding the new one
  }

  // Here the state of order is updated like pending, shipped and delivered
  Future<void> updateOrderStatus(Order order, OrderStatus newStatus) async {
    final box = await Hive.openBox<Order>(boxName);
    final key = box.keys.firstWhere(
      (keys) => box.get(keys) == order,
      // Finds the key of the order to update
      orElse: () => null, // If order is not found it return null
    );

    if (key != null) {
      // If order is found update its status and save it back to Hive
      final updatedOrder = order.copyWith(status: newStatus);
      await box.put(key, updatedOrder); // Save the updated order to the box
      await loadOrders(); // Reload order after updated
    }
  }

  // Clear all orders from the order screen
  Future<void> clearOrders() async {
    final box = await Hive.openBox<Order>(boxName);
    final userEmail =
        ref.read(authProvider)?.email ??
        "guest"; // Get user email or default to "guest"

    // Find keys of orders belonging to the current user
    final keysToDelete = box.keys.where((key) {
      final order = box.get(key);
      return order?.userEmail == userEmail;
    }).toList();

    await box.deleteAll(
      keysToDelete,
    ); // Delete the selected orders from the box
    await loadOrders(); // Reload the orders after clearing them
  }
}

// Order provider
final orderProvider = StateNotifierProvider<OrderNotifier, List<Order>>(
  (ref) => OrderNotifier(ref),
);
