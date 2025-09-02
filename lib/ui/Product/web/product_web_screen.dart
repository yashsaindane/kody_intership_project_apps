import 'package:flutter/material.dart';
import 'package:shopping_web_app/ui/product/web/profile/profile_web_screen.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import 'helper/custom_web_grid_view.dart';
import 'orders/orders_web_screen.dart';

class ProductWebScreen extends StatelessWidget {
  const ProductWebScreen({super.key});

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
      body: Padding(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: [CustomWebGridView()]),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined),
            label: TextClass.productsLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping),
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
