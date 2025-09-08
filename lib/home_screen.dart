import 'package:flutter/material.dart';
import 'package:shopping_web_app/UI/Product/mobile/product_mobile_screen.dart';
import 'package:shopping_web_app/UI/Product/web/product_web_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const int webMinWidth = 769;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        if (width >= webMinWidth) {
          return const ProductWebScreen();
        } else {
          return const ProductMobileScreen();
        }
      },
    );
  }
}
