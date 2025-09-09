import 'package:flutter/material.dart';

import 'UI/Auth/mobile/auth/login_mobile_screen.dart';
import 'UI/Auth/web/auth/login_web_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const int webMinWidth = 769;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = MediaQuery.of(context).size.width;
        if (width >= webMinWidth) {
          return const LoginWebScreen();
        } else {
          return const LoginMobileScreen();
        }
      },
    );
  }
}
