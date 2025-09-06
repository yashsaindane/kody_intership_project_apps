import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/ui/Product/mobile/product_mobile_screen.dart';
import 'package:shopping_web_app/ui/Profile/mobile/profile_mobile_screen.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';

import '../../Orders/mobile/order_mobile_screen.dart';

class CustomMobileDrawer extends ConsumerStatefulWidget {
  const CustomMobileDrawer({super.key});

  @override
  ConsumerState<CustomMobileDrawer> createState() => _CustomMobileDrawerState();
}

class _CustomMobileDrawerState extends ConsumerState<CustomMobileDrawer> {
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
              TextClass.menu,
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
                    MaterialPageRoute(
                      builder: (context) => ProductMobileScreen(),
                    ),
                  );
                },
                child: Text(
                  TextClass.product,
                  style: TextStyle(color: AppColors.textColor, fontSize: 18),
                ),
              ),
            ),
            ListTile(
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderMobileScreen(),
                    ),
                  );
                },
                child: Text(
                  TextClass.order,
                  style: TextStyle(color: AppColors.textColor, fontSize: 18),
                ),
              ),
            ),
            ListTile(
              title: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileMobileScreen(),
                    ),
                  );
                },
                child: Text(
                  TextClass.profileLabel,
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
