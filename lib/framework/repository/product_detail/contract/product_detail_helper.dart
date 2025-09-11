import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/framework/controller/product_detail/product_detail_provider.dart';

import '../../product_screen/model/product_model.dart';

class ProductDetailLogic {
  static ({ProductsList? product, List<String> images, Widget? fallback})
  getSelectedProductAndImages(WidgetRef ref) {
    final productList = ref.watch(selectedProductProvider).productList;
    final selectedProduct = productList.isNotEmpty ? productList.last : null;

    if (selectedProduct == null) {
      return (
        product: null,
        images: [],
        fallback: Scaffold(
          appBar: AppBar(title: Text(TextClass.productDetails)),
          body: Center(child: Text(TextClass.noProductSelected)),
        ),
      );
    }

    return (
      product: selectedProduct,
      images: selectedProduct.imageUrl ?? [],
      fallback: null,
    );
  }
}
