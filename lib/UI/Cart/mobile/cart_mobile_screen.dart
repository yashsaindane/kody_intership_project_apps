import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Cart/mobile/helper/custom_mobile_listview.dart';
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
    // final cartNotifier = ref.read(cartProvider.notifier);
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
            CustomMobileListview(),
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
