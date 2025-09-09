import 'package:hive/hive.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/hive_cart_model.dart';

class CartService {
  // Fetch the userEmail from SharedPreferences
  Future<String> getUserEmail() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userEmail') ?? '';
  }

  // Save userEmail to SharedPreferences
  Future<void> saveUserEmail(String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
  }

  // Generate box name based on user email
  Future<String> _getCartBoxName() async {
    final email = await getUserEmail();
    return '${email}_cartBox'; // e.g., user@example.com_cartBox
  }

  // Open Hive box for CartProduct with user-specific name
  Future<Box<CartProduct>> openCartBox() async {
    final boxName = await _getCartBoxName();
    return await Hive.openBox<CartProduct>(boxName);
  }

  // Add CartProduct to Hive local database using productId as key
  Future<void> addCartProduct(CartProduct cartProduct) async {
    final cartBox = await openCartBox();
    await cartBox.put(cartProduct.productId, cartProduct);
  }

  // Get CartProduct by productId
  Future<CartProduct?> getCartProduct(int productId) async {
    final cartBox = await openCartBox();
    return cartBox.get(productId);
  }

  // Get all CartProducts for the current user
  Future<List<CartProduct>> getAllCartProducts() async {
    final cartBox = await openCartBox();
    return cartBox.values.toList();
  }

  // Update a CartProduct
  Future<void> updateCartProduct(CartProduct updatedProduct) async {
    final cartBox = await openCartBox();
    await cartBox.put(updatedProduct.productId, updatedProduct);
  }

  // Remove CartProduct by productId
  Future<void> removeCartProduct(int productId) async {
    final cartBox = await openCartBox();
    await cartBox.delete(productId);
  }

  // Optional: Clear all items from the user's cart
  Future<void> clearCart() async {
    final cartBox = await openCartBox();
    await cartBox.clear();
  }
}
