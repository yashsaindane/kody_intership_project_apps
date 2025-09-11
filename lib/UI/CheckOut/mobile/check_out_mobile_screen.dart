import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/CheckOut/mobile/helper/custom_checkout_mobile_listview.dart';
import 'package:shopping_web_app/UI/Orders/mobile/order_mobile_screen.dart';
import 'package:shopping_web_app/UI/utils/theme/app_colors.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/controller/cart/cart_provider.dart';
import 'package:shopping_web_app/framework/repository/order/model/hive_order_model.dart';
import 'package:shopping_web_app/framework/repository/order/repository/order_service.dart';

class CheckOutMobileScreen extends ConsumerStatefulWidget {
  const CheckOutMobileScreen({super.key});

  @override
  ConsumerState<CheckOutMobileScreen> createState() =>
      _CheckOutMobileScreenState();
}

class _CheckOutMobileScreenState extends ConsumerState<CheckOutMobileScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final totalPrice = ref.watch(totalPriceProvider);
    final auth = ref.watch(authProvider);
    final userEmail = auth?.email ?? "guest";

    return Scaffold(
      appBar: AppBar(
        title: Text(TextClass.checkout),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Expanded(child: CustomCheckoutMobileListview()),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    TextClass.total,
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "₹${totalPrice.toStringAsFixed(2)}",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: () async {
                  final order = Order(
                    products: cart,
                    totalPrice: totalPrice,
                    orderDate: DateTime.now(),
                    status: OrderStatus.pending,
                    imageUrl: cart
                        .map((product) => product.imageUrl.first)
                        .toList(),
                    userEmail: userEmail,
                  );
                  await OrderService.addOrder(order);
                  await ref.read(cartProvider.notifier).clearCart();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderMobileScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: AppColors.secondaryColor,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  TextClass.placeOrder,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
