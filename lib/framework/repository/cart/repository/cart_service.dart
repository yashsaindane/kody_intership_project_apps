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

  // Open Hive box for CartProduct
  Future<Box<CartProduct>> openCartBox() async {
    return await Hive.openBox<CartProduct>('cartBox');
  }

  // Add CartProduct to Hive local database here productid is used as key
  Future<void> addCartProduct(CartProduct cartProduct) async {
    final Box<CartProduct> cartBox = await openCartBox();
    await cartBox.put(cartProduct.productId, cartProduct);
  }

  // Get CartProduct from Hive local database by using productId
  Future<CartProduct?> getCartProduct(int productId) async {
    final Box<CartProduct> cartBox = await openCartBox();
    return cartBox.get(productId);
  }

  // Get all CartProducts from Hive local database
  Future<List<CartProduct>> getAllCartProducts() async {
    final Box<CartProduct> cartBox = await openCartBox();
    return cartBox.values.toList();
  }

  // Update CartProduct in Hive local database
  Future<void> updateCartProduct(CartProduct updatedProduct) async {
    final Box<CartProduct> cartBox = await openCartBox();
    await cartBox.put(updatedProduct.productId, updatedProduct);
  }

  // Remove CartProduct from Hive local database
  Future<void> removeCartProduct(int productId) async {
    final Box<CartProduct> cartBox = await openCartBox();
    await cartBox.delete(productId);
  }
}
