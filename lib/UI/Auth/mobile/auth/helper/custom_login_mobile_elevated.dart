import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../framework/controller/auth_controller/auth/auth_provider.dart';
import '../../../../../framework/controller/auth_controller/auth/login_controller.dart';
import '../../../../Product/mobile/product_mobile_screen.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/text_class.dart';

class CustomLoginMobileElevated extends ConsumerStatefulWidget {
  const CustomLoginMobileElevated({super.key});

  @override
  ConsumerState<CustomLoginMobileElevated> createState() =>
      _CustomLoginMobileElevatedState();
}

class _CustomLoginMobileElevatedState
    extends ConsumerState<CustomLoginMobileElevated> {
  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () async {
        final email = LoginController.loginEmailController.text.trim();
        final password = LoginController.loginPasswordController.text.trim();
        if (email.isNotEmpty && password.isNotEmpty) {
          final success = await authNotifier.login(email, password);
          if (success) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Logged in as $email"),
                backgroundColor: AppColors.successColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ProductMobileScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Invalid credentials"),
                behavior: SnackBarBehavior.floating,
                backgroundColor: AppColors.errorColor,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              duration: Duration(milliseconds: 300),
              content: Text(TextClass.pleaseEnterEmailPassword),
              backgroundColor: AppColors.errorColor,
            ),
          );
          LoginController.loginPasswordController.clear();
          LoginController.loginEmailController.clear();
        }
      },
      child: Text(
        TextClass.login,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
