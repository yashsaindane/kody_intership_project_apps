import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shopping_web_app/framework/repository/order/model/hive_order_model.dart';
import 'package:shopping_web_app/ui/splash_screen.dart';

import 'framework/repository/cart/model/hive_cart_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CartProductAdapter());
  Hive.registerAdapter(ProductStatusAdapter());
  Hive.registerAdapter(OrderAdapter());
  Hive.registerAdapter(OrderStatusAdapter());
  await Hive.openBox<CartProduct>('cartBox');
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // final width = constraints.maxWidth;
        // debugPrint("App width: $width");
        return ScreenUtilInit(
          designSize: const Size(375, 812),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Shopping App',
            theme: ThemeData(splashColor: Colors.transparent),
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}
