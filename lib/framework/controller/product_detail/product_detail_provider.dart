import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/framework/repository/product_screen/model/product_model.dart';

// Provider
final selectedProductProvider = ChangeNotifierProvider<MyList>((ref) {
  return MyList();
});

class MyList extends ChangeNotifier {
  List<ProductsList> productList = [];

  // Add a product to show specific product in detail screen
  void addPro(ProductsList product) {
    productList.add(product);
    notifyListeners();
  }

  // void clear() {
  //   productList.clear();
  //   notifyListeners();
  // }

  // Gets the product by index
  ProductsList getIndex(int index) {
    return productList[index];
  }
}

final boxExpandProvider = StateProvider<bool>((ref) => false);
