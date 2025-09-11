import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Auth/mobile/auth/register_mobile_screen.dart';
import 'package:shopping_web_app/UI/Orders/mobile/helper/custom_mobile_choice_listview.dart';
import 'package:shopping_web_app/UI/Orders/mobile/helper/custom_order_mobile_listview.dart';
import 'package:shopping_web_app/UI/Product/mobile/product_mobile_screen.dart';
import 'package:shopping_web_app/UI/utils/theme/app_colors.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/controller/order/order_provider.dart';
import 'package:shopping_web_app/framework/repository/order/model/hive_order_model.dart';

class OrderMobileScreen extends ConsumerStatefulWidget {
  const OrderMobileScreen({super.key});

  @override
  ConsumerState<OrderMobileScreen> createState() => _OrderMobileScreenState();
}

class _OrderMobileScreenState extends ConsumerState<OrderMobileScreen> {
  OrderStatus? selectedFilter;

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authProvider);

    if (auth != null && !auth.isGuest) {
      ref.read(orderProvider.notifier).loadOrders();
    }
    final orders = ref.watch(orderProvider);

    if (auth == null || auth.isGuest) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            TextClass.order,
            style: TextStyle(color: AppColors.textColor),
          ),
          leading: InkWell(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => ProductMobileScreen()),
                (route) => route.isCurrent,
              );
            },
            child: Icon(Icons.arrow_back, color: AppColors.textColor),
          ),
          backgroundColor: AppColors.primaryColor,
        ),
        body: Center(
          child: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => RegisterMobileScreen()),
              );
            },
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textColor,
                ),
                children: [
                  TextSpan(
                    text: "Register  ",
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextSpan(text: "to see your orders"),
                ],
              ),
            ),
          ),
        ),
      );
    }
    // final filteredOrders = selectedFilter == null
    //     ? orders
    //     : orders.where((order) => order.status == selectedFilter).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextClass.order,
          style: TextStyle(color: AppColors.textColor),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ProductMobileScreen()),
              (route) => route.isCurrent,
            );
          },
          child: Icon(Icons.arrow_back, color: AppColors.textColor),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60, child: CustomMobileChoiceListview()),
            const SizedBox(height: 16),
            Expanded(child: CustomOrderMobileListview()),
          ],
        ),
      ),
    );
  }
}
