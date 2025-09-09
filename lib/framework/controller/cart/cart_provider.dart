import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';

import '../../repository/cart/model/hive_cart_model.dart';
import '../../repository/cart/repository/cart_service.dart';

final cartService =
    CartService(); // Instance of CartService to manage cart operations

// Cart Provider is used to handle state and  storing a list of CartProduct objects
final cartProvider = StateNotifierProvider<CartNotifier, List<CartProduct>>((
  ref,
) {
  return CartNotifier(); // here created an instance of CartNotifier
});

class CartNotifier extends StateNotifier<List<CartProduct>> {
  CartNotifier() : super([]); // Initialize cart as an empty list

  // This Function add product to cart
  Future<void> addToCart(CartProduct cartProduct) async {
    // Check if the product already exists in the cart
    final existingProductIndex = state.indexWhere(
      (product) =>
          product.productId ==
          cartProduct.productId, //here productId is used as a unique key
    );

    if (existingProductIndex == -1) {
      // it check if product doesn't exist in cart, then add that product to cart
      await cartService.addCartProduct(
        cartProduct,
      ); // Save product in the cart service(Hive local database)
      state = [...state, cartProduct];
    } else {
      // If product exists, increase its quantity by 1
      state[existingProductIndex].quantity++;
      state = [...state]; // here the state is changes as updated
    }
  }

  // Remove product from cart by productId unique key
  Future<void> removeFromCart(int productId) async {
    final existingProductIndex = state.indexWhere(
      (product) => product.productId == productId,
    );

    if (existingProductIndex != -1) {
      await cartService.removeCartProduct(
        productId,
      ); // Remove product from the hive local storage
      state = state
          .where((product) => product.productId != productId)
          .toList(); // Update state to remove the product
    }
  }

  // Increase product quantity by 1
  Future<void> increaseQuantity(int productId) async {
    final existingProductIndex = state.indexWhere(
      (product) => product.productId == productId,
    );
    if (existingProductIndex != -1) {
      state[existingProductIndex].quantity++; // Increase the quantity
      state = [...state]; //  updated the state
    }
  }

  // Decrease product quantity by 1 (or remove if quantity is 1)
  Future<void> decreaseQuantity(int productId) async {
    final existingProductIndex = state.indexWhere(
      (product) => product.productId == productId,
    );
    if (existingProductIndex != -1) {
      if (state[existingProductIndex].quantity > 1) {
        // Only decreases if quantity is more than 1
        state[existingProductIndex].quantity--; // Decrease quantity
        state = [...state]; // updates the state
      } else {
        // If quantity is 1, remove the product from the cart
        await cartService.removeCartProduct(
          productId,
        ); // Removed from the hive local database
        state = state
            .where(
              (product) => product.productId != productId,
            ) // Update state by removing the product
            .toList();
      }
    }
  }

  // This function update the quantity of a specific product in the cart if its changed
  void updateCart(CartProduct cartProduct, int quantity) {
    final productIndex = state.indexWhere(
      (product) => product.productId == cartProduct.productId,
    );
    if (productIndex != -1) {
      if (quantity > 0) {
        state[productIndex].quantity = quantity; // Update quantity
        state = [...state]; // pdates state
      } else {
        removeFromCart(
          cartProduct.productId,
        ); // Removes product if quantity is 0
      }
    }
  }

  // Load all cart products from Hive local storage
  Future<void> loadCart() async {
    final cartProducts = await cartService
        .getAllCartProducts(); // Fetch cart data from local storage
    state = cartProducts; // Updates the state with the loaded products
  }

  // Clear all cart data
  Future<void> clearCart() async {
    final box = await Hive.openBox<CartProduct>(
      'cartBox',
    ); // Open cart storage box in Hive
    await box.clear(); // Clear all items from the cart
    state = [];
  }
}

// Provider to calculate the total price of items in the cart
final totalPriceProvider = Provider<double>((ref) {
  // It is used to get the list of products in the cart
  final cart = ref.watch(cartProvider);
  double total = 0;
  for (final item in cart) {
    total +=
        item.productPrice *
        item.quantity; // Multiply price by quantity for each product
  }
  return total; // Return the total price
});
