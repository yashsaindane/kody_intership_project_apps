import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import '../../../framework/provider/product_detail/product_provider.dart';
import '../../Cart/web/cart_web_screen.dart';
import '../../Orders/web/orders_web_screen.dart';
import '../../Profile/web/profile_web_screen.dart';
import '../../utils/theme/app_colors.dart';
import 'helper/custom_web_grid_view.dart';

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
    final isBoxExpanded = ref.watch(boxExpandProvider);
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          TextClass.productTitle,
          style: TextStyle(color: AppColors.textColor, fontSize: 22),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartWebScreen()),
                );
              },
              child: Icon(
                Icons.shopping_cart_outlined,
                color: AppColors.secondaryColor,
                size: 30,
              ),
            ),
          ),
        ],
        backgroundColor: AppColors.primaryColor,
      ),
      body: Row(
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: isBoxExpanded ? 200 : 30,
            height: screenHeight,
            color: isBoxExpanded
                ? AppColors.secondaryColor
                : AppColors.backgroundColor,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    ref.read(boxExpandProvider.notifier).state = !ref.read(
                      boxExpandProvider,
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      isBoxExpanded ? Icons.arrow_left : Icons.arrow_right,
                      size: 20,
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                if (isBoxExpanded)
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          TextClass.productsLabel,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          TextClass.ordersLabel,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 20,
                          ),
                        ),
                        Text(
                          TextClass.profileLabel,
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(children: [CustomWebGridView()]),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        onTap: (index) => _onItemTapped(context, index),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart_outlined, size: 25),
            label: TextClass.productsLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long, size: 25),
            label: TextClass.ordersLabel,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, size: 25),
            label: TextClass.profileLabel,
          ),
        ],
      ),
    );
  }
}
