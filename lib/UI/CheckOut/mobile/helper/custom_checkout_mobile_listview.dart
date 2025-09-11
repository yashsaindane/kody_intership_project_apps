import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../framework/controller/cart/cart_provider.dart';

class CustomCheckoutMobileListview extends ConsumerStatefulWidget {
  const CustomCheckoutMobileListview({super.key});

  @override
  ConsumerState<CustomCheckoutMobileListview> createState() =>
      _CustomCheckoutMobileListviewState();
}

class _CustomCheckoutMobileListviewState
    extends ConsumerState<CustomCheckoutMobileListview> {
  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    return ListView.builder(
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
    );
  }
}
