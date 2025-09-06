import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Product/mobile/helper/custom_mobile_list_view.dart';
import 'package:shopping_web_app/ui/Drawer/mobile/custom_mobile_drawer.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import '../../Orders/mobile/order_mobile_screen.dart';
import '../../Profile/mobile/profile_mobile_screen.dart';

class ProductMobileScreen extends ConsumerStatefulWidget {
  const ProductMobileScreen({super.key});

  @override
  ConsumerState<ProductMobileScreen> createState() =>
      _ProductMobileScreenState();
}

class _ProductMobileScreenState extends ConsumerState<ProductMobileScreen> {
  void _onItemTapped(BuildContext context, int index) {
    if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => OrderMobileScreen()),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfileMobileScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomMobileDrawer(),
      appBar: AppBar(
        title: Text(
          TextClass.productTitle,
          style: TextStyle(color: AppColors.textColor, fontSize: 24),
        ),
        backgroundColor: AppColors.primaryColor,
      ),
      body: Padding(padding: EdgeInsets.all(10), child: CustomMobileListView()),
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
