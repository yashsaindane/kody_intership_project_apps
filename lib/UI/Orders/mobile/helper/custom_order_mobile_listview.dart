import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../framework/controller/order/order_provider.dart';
import '../../../../framework/repository/order/model/hive_order_model.dart';
import '../../../utils/theme/app_colors.dart';

class CustomOrderMobileListview extends ConsumerStatefulWidget {
  const CustomOrderMobileListview({super.key});

  @override
  ConsumerState<CustomOrderMobileListview> createState() =>
      _CustomOrderMobileListviewState();
}

class _CustomOrderMobileListviewState
    extends ConsumerState<CustomOrderMobileListview> {
  OrderStatus? selectedFilter;

  @override
  Widget build(BuildContext context) {
    final orders = ref.watch(orderProvider);
    final filteredOrders = selectedFilter == null
        ? orders
        : orders.where((order) => order.status == selectedFilter).toList();
    return ListView.builder(
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
                      child: Text(status.name, style: TextStyle(fontSize: 12)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
