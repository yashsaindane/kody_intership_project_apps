import 'package:hive/hive.dart';

import '../model/hive_order_model.dart';

class OrderService {
  static const String boxName = 'ordersBox';

  // Here Hive box is opened
  static Future<Box<Order>> _openBox() async {
    return await Hive.openBox<Order>(boxName);
  }

  //Here new order are saving in the Hive box
  static Future<void> addOrder(Order order) async {
    final box = await _openBox();
    await box.add(order);
  }

  // Here orders are retrieve for specific user using get method and based on emailId that is fetch from the shared preference data
  static Future<List<Order>> getOrders(String userEmail) async {
    final box = await _openBox();
    return box.values.where((order) => order.userEmail == userEmail).toList();
  }

  // Here data is update
  static Future<void> updateOrder(int key, Order order) async {
    final box = await _openBox();
    await box.put(key, order);
  }

  //Here is the orders are deleted
  static Future<void> deleteOrder(int key) async {
    final box = await _openBox();
    await box.delete(key);
  }

  static Future<List<Order>> getOrdersByUser(String userEmail) async {
    final box = await _openBox();
    return box.values.where((o) => o.userEmail == userEmail).toList();
  }
}
