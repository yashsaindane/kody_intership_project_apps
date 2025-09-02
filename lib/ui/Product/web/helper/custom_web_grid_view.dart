import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../framework/controller/product_controller/product_provider.dart';
import '../../../Cart/mobile/cart_mobile_screen.dart';
import '../../../Product_details/mobile/product_detail_mobile_screen.dart';
import '../../../utils/theme/app_colors.dart';

class CustomWebGridView extends ConsumerStatefulWidget {
  const CustomWebGridView({super.key});

  @override
  ConsumerState<CustomWebGridView> createState() => _CustomWebGridViewState();
}

class _CustomWebGridViewState extends ConsumerState<CustomWebGridView> {
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
          margin: EdgeInsets.all(10),
          child: ListTile(
            leading: Image.network(
              product.imageUrl?.first ?? 'error',
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            title: Text(product.productName ?? 'erroe'),
            subtitle: Text(
              '₹${product.productPrice?.toStringAsFixed(2) ?? 'error'}',
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
