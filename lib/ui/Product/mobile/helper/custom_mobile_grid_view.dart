import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/ui/Cart/mobile/cart_mobile_screen.dart';
import 'package:shopping_web_app/ui/product_details/mobile/product_detail_mobile_screen.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';

import '../../../../framework/controller/product_controller/product_provider.dart';

class CustomMobileGridView extends ConsumerStatefulWidget {
  const CustomMobileGridView({super.key});

  @override
  ConsumerState<CustomMobileGridView> createState() =>
      _CustomMobileGridViewState();
}

class _CustomMobileGridViewState extends ConsumerState<CustomMobileGridView> {
  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productListProvider);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return Card(
          elevation: 6,
          margin: EdgeInsets.all(8),
          child: ListTile(
            leading: Image.network(
              product.imageUrl?.first ?? '',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(
              product.productName ?? '',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.productInfo ?? 'error',
                  style: TextStyle(color: AppColors.textColor),
                ),
                SizedBox(height: 10),
                Text(
                  '₹${product.productPrice?.toStringAsFixed(2) ?? 'error'}',
                  style: TextStyle(color: AppColors.textColor, fontSize: 16),
                ),
              ],
            ),
            trailing: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartMobileScreen()),
                );
              },
              child: Icon(
                product.productTrailingIcon,
                color: AppColors.secondaryColor,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailMobileScreen(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
