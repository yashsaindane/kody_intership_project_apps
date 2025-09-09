import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Auth/mobile/auth/register_mobile_screen.dart';
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
    final filteredOrders = selectedFilter == null
        ? orders
        : orders.where((order) => order.status == selectedFilter).toList();
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
            SizedBox(
              height: 60,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  const SizedBox(width: 10),
                  ChoiceChip(
                    label: Text(TextClass.all),
                    selected: selectedFilter == null,
                    onSelected: (bool selected) {
                      setState(() {
                        selectedFilter = null;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  ...OrderStatus.values.map((status) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: ChoiceChip(
                        label: Text(status.name),
                        selected: selectedFilter == status,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedFilter = selected ? status : null;
                          });
                        },
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredOrders.length,
                itemBuilder: (context, index) {
                  final order = filteredOrders[index];
                  return Card(
                    margin: EdgeInsets.all(8),
                    child: ListTile(
                      leading: order.imageUrl.isNotEmpty
                          ? SizedBox(
                              width: 70,
                              child: Wrap(
                                spacing: 2,
                                runSpacing: 2,
                                children: order.imageUrl.map((url) {
                                  return Image.network(
                                    url,
                                    width: 60,
                                    height: 60,
                                    fit: BoxFit.contain,
                                  );
                                }).toList(),
                              ),
                            )
                          : Icon(Icons.image_not_supported, size: 40),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: order.products.map((product) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Product Name: ${product.productName}",
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              Text(
                                "Product ID: ${product.productId}",
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date: ${order.orderDate.toLocal().toString().split(' ')[0]}",
                            style: TextStyle(color: AppColors.textColor),
                          ),
                          Text(
                            "Total Price: ₹${order.totalPrice.toStringAsFixed(2)}",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          DropdownButton<OrderStatus>(
                            value: order.status,
                            onChanged: (newStatus) {
                              if (newStatus != null) {
                                ref
                                    .read(orderProvider.notifier)
                                    .updateOrderStatus(order, newStatus);
                              }
                            },
                            items: OrderStatus.values.map((status) {
                              return DropdownMenuItem(
                                value: status,
                                child: Text(
                                  status.name,
                                  style: TextStyle(fontSize: 12),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
