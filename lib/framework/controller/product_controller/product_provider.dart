import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../respository/product_screen/model/product_model.dart';

final productListProvider = Provider<List<ProductList>>((ref) {
  return productList;
});
