import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailMobileScreen extends ConsumerStatefulWidget {
  const ProductDetailMobileScreen({super.key});

  @override
  ConsumerState<ProductDetailMobileScreen> createState() =>
      _ProductDetailMobileScreenState();
}

class _ProductDetailMobileScreenState
    extends ConsumerState<ProductDetailMobileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Product Detail")));
  }
}
