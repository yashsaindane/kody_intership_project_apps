import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/repository/order/model/hive_order_model.dart';
import 'package:shopping_web_app/framework/repository/order/repository/order_service.dart';

class OrderNotifier extends StateNotifier<List<Order>> {
  final Ref ref; // used for reading providers

  // Constructor of OrderNotifier, initializing with an empty order list
  OrderNotifier(this.ref) : super([]);

  // Its an getter to get current logged in user's email or null if guest/no user
  String? get currentUserEmail {
    final auth = ref.read(authProvider);
    if (auth != null && !auth.isGuest && auth.email.isNotEmpty) {
      return auth.email;
    }
    return null; // guest or no user logged in
  }

  // Load all orders for the current user using per-user Hive box
  Future<void> loadOrders() async {
    final email = currentUserEmail;
    if (email == null) {
      // no valid user, so clear order list
      state = [];
      return;
    }

    // retrieve all orders from user-specific box
    final orders = await OrderService.getOrders();
    state = orders.reversed.toList();
  }

  // Add a new order to the Hive box and reload the orders
  Future<void> addOrder(Order order) async {
    final email = currentUserEmail;
    if (email == null) return; // no user to add order for

    await OrderService.addOrder(order); // Add the new order to the box
    await loadOrders(); // Reload the orders after adding the new one
  }

  // Here the state of order is updated like pending, shipped and delivered
  Future<void> updateOrderStatus(Order order, OrderStatus newStatus) async {
    final email = currentUserEmail;
    if (email == null) return; // no user logged in

    final box = await OrderService.openBox();

    // Finds the key of the order to update
    final key = box.keys.firstWhere(
      (key) => box.get(key) == order,
      orElse: () => null, // If order is not found it returns null
    );

    if (key != null) {
      // If order is found update its status and save it back to Hive
      final updatedOrder = order.copyWith(status: newStatus);
      await OrderService.updateOrder(key, updatedOrder);
      await loadOrders(); // Reload order after updating
    }
  }

  // Clear all orders from the order screen
  Future<void> clearOrders() async {
    final email = currentUserEmail;
    if (email == null) return; // no user logged in

    await OrderService.clearOrders(); // Delete all orders from the box
    await loadOrders(); // Reload the orders after clearing them
  }
}

// Order provider
final orderProvider = StateNotifierProvider<OrderNotifier, List<Order>>(
  (ref) => OrderNotifier(ref),
);
