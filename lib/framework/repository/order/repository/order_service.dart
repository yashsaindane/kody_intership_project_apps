import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/hive_order_model.dart';

class OrderService {
  // Helper method to generate box name based on user email
  static Future<String> _getBoxName() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail') ?? 'guest';
    return '${email}_ordersBox'; // Box name will be like: user@example.com_ordersBox
  }

  // Here Hive box is opened with user-specific name
  static Future<Box<Order>> openBox() async {
    final boxName = await _getBoxName();
    return await Hive.openBox<Order>(boxName);
  }

  // Here new orders are saved in the Hive box
  static Future<void> addOrder(Order order) async {
    final box = await openBox();
    await box.add(order);
  }

  // Here all orders are retrieved (already filtered by user-specific box)
  static Future<List<Order>> getOrders() async {
    final box = await openBox();
    return box.values.toList(); // No need to filter by email anymore
  }

  // Here data is updated using key
  static Future<void> updateOrder(int key, Order order) async {
    final box = await openBox();
    await box.put(key, order);
  }

  // Here the orders are deleted using key
  static Future<void> deleteOrder(int key) async {
    final box = await openBox();
    await box.delete(key);
  }

  // clear all orders for current user
  static Future<void> clearOrders() async {
    final box = await openBox();
    await box.clear();
  }
}
