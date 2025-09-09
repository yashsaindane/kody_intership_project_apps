import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../repository/product_screen/model/product_model.dart';

//Provider provide single product in product detail screen
final selectedProductProvider = ChangeNotifierProvider((ref) {
  return MyList();
});

class MyList extends ChangeNotifier {
  List<ProductsList> productList = [];

  void addElement(ProductsList product) {
    productList.add(product);
    notifyListeners();
    ProductsList getByIndex(int index) {
      return productList[index];
    }
  }
}

final boxExpandProvider = StateProvider<bool>((ref) => false);
