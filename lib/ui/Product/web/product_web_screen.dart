import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/ui/Product/web/helper/custom_web_grid_view.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import '../../Orders/web/orders_web_screen.dart';
import '../../Profile/web/profile_web_screen.dart';
import '../../utils/theme/app_colors.dart';

class ProductWebScreen extends ConsumerStatefulWidget {
  const ProductWebScreen({super.key});

  @override
  ConsumerState<ProductWebScreen> createState() => _ProductWebScreenState();
}

class _ProductWebScreenState extends ConsumerState<ProductWebScreen> {
  void _onItemTapped(BuildContext context, int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrdersWebScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileWebScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextClass.productTitle,
          style: TextStyle(color: AppColors.textColor),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [CustomWebGridView()]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) => _onItemTapped(context, index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: TextClass.productsLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: TextClass.ordersLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: TextClass.profileLabel,
          ),
        ],
      ),
    );
  }
}
