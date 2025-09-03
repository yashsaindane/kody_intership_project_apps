import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../respository/product_screen/model/product_model.dart';

final productListProvider = Provider<List<ProductList>>((ref) {
  return productList;
});

final selectedProductProvider = StateProvider<ProductList?>((ref) => null);

enum ProductSortType { name, category, price }

final sortTypeProvider = StateProvider<ProductSortType>(
  (ref) => ProductSortType.name,
);

final sortListProvider = Provider<List<ProductList>>((ref) {
  final sortType = ref.watch(sortTypeProvider);
  final allProducts = productList;

  List<ProductList> sortedList = List.from(allProducts);

  switch (sortType) {
    case ProductSortType.name:
      sortedList.sort(
        (a, b) => (a.productName ?? '').toLowerCase().compareTo(
          (b.productName ?? '').toLowerCase(),
        ),
      );
      break;
    case ProductSortType.category:
      sortedList.sort(
        (a, b) => (a.category ?? '').toLowerCase().compareTo(
          (b.category ?? '').toLowerCase(),
        ),
      );
      break;
    case ProductSortType.price:
      sortedList.sort(
        (a, b) => (a.productPrice ?? 0).compareTo(b.productPrice ?? 0),
      );
      break;
  }

  return sortedList;
});
