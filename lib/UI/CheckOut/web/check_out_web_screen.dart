import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Orders/web/orders_web_screen.dart';
import 'package:shopping_web_app/UI/utils/theme/app_colors.dart';

import '../../../framework/provider/auth/auth_provider.dart';
import '../../../framework/provider/cart/cart_provider.dart';
import '../../../framework/repository/order/model/hive_order_model.dart';
import '../../../framework/repository/order/repository/order_service.dart';
import '../../utils/theme/text_class.dart';

class CheckOutWebScreen extends ConsumerStatefulWidget {
  const CheckOutWebScreen({super.key});

  @override
  ConsumerState<CheckOutWebScreen> createState() => _CheckOutWebScreenState();
}

class _CheckOutWebScreenState extends ConsumerState<CheckOutWebScreen> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final totalPrice = ref.watch(totalPriceProvider);
    final auth = ref.watch(authProvider);
    final userEmail = auth?.email ?? "guest";
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: Text(TextClass.checkout),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    final product = cart[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        leading: product.imageUrl.isNotEmpty
                            ? Image.network(
                                product.imageUrl.first,
                                width: 70,
                                height: 70,
                                fit: BoxFit.cover,
                              )
                            : Icon(Icons.image_not_supported, size: 50),
                        title: Text(product.productName ?? ''),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Price: ₹${(product.productPrice ?? 0).toStringAsFixed(2)}",
                            ),
                            Text("Quantity: ${product.quantity}"),
                          ],
                        ),
                        trailing: Text(
                          "₹${(product.productPrice ?? 0) * product.quantity}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 25,
                  horizontal: 20,
                ),
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
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
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
                        builder: (context) => OrdersWebScreen(),
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
      ),
    );
  }
}
