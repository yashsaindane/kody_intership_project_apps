import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/product_screen/model/product_model.dart';

//Product provider
final productListProvider = Provider<List<ProductsList>>((ref) {
  return productList;
});

//Provider provide single product in product detail screen
final selectedProductProvider = StateProvider<ProductsList?>((ref) => null);

final boxExpandProvider = StateProvider<bool>((ref) => false);

//Sorting Enums
enum ProductSortType { name, category }

enum ProductCategory { shoes, headphones, laptops, speakers }

//Extension on ProductCategory of labels for categories
extension ProductCategoryExt on ProductCategory {
  String get label {
    switch (this) {
      case ProductCategory.shoes:
        return "Shoes";
      case ProductCategory.headphones:
        return "Headphones";
      case ProductCategory.laptops:
        return "Laptops";
      case ProductCategory.speakers:
        return "Speakers";
    }
  }
}

// Provider to sorting by name
final sortTypeProvider = StateProvider<ProductSortType>(
  (ref) => ProductSortType.name,
);

// Cartegory provider
final categoryFilterProvider = StateProvider<ProductCategory?>((ref) => null);

final sortListProvider = Provider<List<ProductsList>>((ref) {
  final sortType = ref.watch(sortTypeProvider);
  final selectedCategory = ref.watch(categoryFilterProvider);

  // Filters products by selected category
  List<ProductsList> filteredList = selectedCategory == null
      ? List.from(productList) // If no category is selected, shows all product
      : productList
            .where((pro) => pro.category == selectedCategory)
            .toList(); // Filtered by selected category

  // Sort the filtered based on the selected type
  switch (sortType) {
    case ProductSortType.name:
      // Sort alphabetically by product name
      filteredList.sort(
        (a, b) =>
            a.productName.toLowerCase().compareTo(b.productName.toLowerCase()),
      );
      break;
    case ProductSortType.category:
      // Sort by category name alphabetically
      filteredList.sort(
        (a, b) => (a.category?.label ?? '').compareTo(b.category?.label ?? ''),
      );
      break;
  }

  return filteredList; // Return the filtered and sorted list of products
});
