import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../framework/controller/cart/cart_provider.dart';
import '../../../../framework/controller/product_detail/product_detail_provider.dart';
import '../../../../framework/repository/cart/model/hive_cart_model.dart';
import '../../../Cart/mobile/cart_mobile_screen.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/text_class.dart';

class CustomModileProductdetailElevated extends ConsumerWidget {
  const CustomModileProductdetailElevated({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedProductList = ref.watch(selectedProductProvider).productList;
    final selectedProduct = selectedProductList.isNotEmpty
        ? selectedProductList.last
        : null;
    if (selectedProduct == null) {
      return Scaffold(
        appBar: AppBar(title: Text(TextClass.productDetails)),
        body: Center(child: Text(TextClass.noProductSelected)),
      );
    }
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        backgroundColor: AppColors.secondaryColor,
      ),
      onPressed: () {
        final cartProduct = CartProduct(
          productId: int.tryParse(selectedProduct.productId ?? '0') ?? 0,
          productName: selectedProduct.productName ?? '',
          productPrice: selectedProduct.productPrice ?? 0,
          quantity: 1,

          imageUrl: selectedProduct.imageUrl ?? [],
          dateTime: DateTime.now(),
          status: ProductStatus.pending,
          userEmail: '',
        );
        ref.read(cartProvider.notifier).addToCart(cartProduct);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(TextClass.productAddedToCart),
            backgroundColor: AppColors.successColor,
            behavior: SnackBarBehavior.floating,
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CartMobileScreen()),
        );
      },
      child: Text(
        TextClass.addToCart,
        style: TextStyle(color: AppColors.textColor),
      ),
    );
  }
}
