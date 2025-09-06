import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Orders/web/orders_web_screen.dart';
import '../../Product/web/product_web_screen.dart';
import '../../Profile/web/profile_web_screen.dart';
import '../../utils/theme/app_colors.dart';

class CustomWebDrawer extends ConsumerStatefulWidget {
  const CustomWebDrawer({super.key});

  @override
  ConsumerState<CustomWebDrawer> createState() => _CustomWebDrawerState();
}

class _CustomWebDrawerState extends ConsumerState<CustomWebDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.backgroundColor,
      width: 230,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Menu",
              style: TextStyle(
                color: AppColors.textColor,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(thickness: 2),
            ListTile(
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProductWebScreen()),
                  );
                },
                child: Text(
                  "Product",
                  style: TextStyle(color: AppColors.textColor, fontSize: 18),
                ),
              ),
            ),
            ListTile(
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => OrdersWebScreen()),
                  );
                },
                child: Text(
                  "Orders",
                  style: TextStyle(color: AppColors.textColor, fontSize: 18),
                ),
              ),
            ),
            ListTile(
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileWebScreen()),
                  );
                },
                child: Text(
                  "Profile",
                  style: TextStyle(color: AppColors.textColor, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
