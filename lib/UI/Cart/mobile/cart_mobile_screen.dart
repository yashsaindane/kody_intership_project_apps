import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/CheckOut/mobile/check_out_mobile_screen.dart';
import 'package:shopping_web_app/UI/utils/theme/app_colors.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/controller/cart/cart_provider.dart';

class CartMobileScreen extends ConsumerStatefulWidget {
  const CartMobileScreen({super.key});

  @override
  ConsumerState<CartMobileScreen> createState() => _CartMobileScreenState();
}

class _CartMobileScreenState extends ConsumerState<CartMobileScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);
    final authState = ref.watch(authProvider);
    final isGuest = authState == null || !authState.isLogin;
    return Scaffold(
      appBar: AppBar(
        title: Text(TextClass.carts),
        backgroundColor: AppColors.primaryColor,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final product = cart[index];
                return Card(
                  elevation: 6,
                  margin: EdgeInsets.all(8),
                  child: ListTile(
                    leading: Image.network(
                      product.imageUrl.first ?? '',
                      width: 90,
                      height: 90,
                      fit: BoxFit.cover,
                    ),
                    title: Text(
                      product.productName ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '₹${product.productPrice}',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: Card(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: Icon(Icons.remove, size: 20),
                                  onPressed: () {
                                    if (product.quantity > 1) {
                                      cartNotifier.updateCart(
                                        product,
                                        product.quantity - 1,
                                      );
                                    } else {
                                      cartNotifier.updateCart(product, 0);
                                    }
                                  },
                                ),
                                Text(
                                  '${product.quantity}',
                                  style: TextStyle(fontSize: 16),
                                ),
                                IconButton(
                                  icon: Icon(Icons.add, size: 20),
                                  onPressed: () {
                                    cartNotifier.updateCart(
                                      product,
                                      product.quantity + 1,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

            SizedBox(height: 20),
            SizedBox(
              height: 45,
              width: double.maxFinite,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: AppColors.secondaryColor,
                ),
                onPressed: () {
                  if (isGuest) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Login/Register to checkout"),
                        backgroundColor: AppColors.errorColor,
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  } else if (cart.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CheckOutMobileScreen(),
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          TextClass.checkout,
                          style: TextStyle(color: AppColors.textColor),
                        ),
                        backgroundColor: AppColors.successColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(milliseconds: 100),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 10),
                        content: Text(
                          TextClass
                              .yourCartIsemptyAddsomeproductstoPlaceanOrder,
                        ),
                      ),
                    );
                  }
                },
                child: Text(
                  TextClass.checkout,
                  style: TextStyle(color: AppColors.textColor),
                ),
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
