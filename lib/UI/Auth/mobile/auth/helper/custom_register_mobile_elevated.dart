import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../framework/controller/auth_controller/auth/auth_provider.dart';
import '../../../../../framework/controller/auth_controller/auth/login_controller.dart';
import '../../../../Product/mobile/product_mobile_screen.dart';
import '../../../../utils/theme/app_colors.dart';
import '../../../../utils/theme/text_class.dart';

class CustomRegisterMobileElevated extends ConsumerStatefulWidget {
  const CustomRegisterMobileElevated({super.key});

  @override
  ConsumerState<CustomRegisterMobileElevated> createState() =>
      _CustomRegisterMobileElevatedState();
}

class _CustomRegisterMobileElevatedState
    extends ConsumerState<CustomRegisterMobileElevated> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    final authNotifier = ref.read(authProvider.notifier);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.secondaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      onPressed: () async {
        final name = LoginController.registerNameController.text.trim();
        final email = LoginController.registerEmailController.text.trim();
        final password = LoginController.registerPasswordController.text.trim();
        if (email.isNotEmpty && password.isNotEmpty) {
          await authNotifier.registerUser(
            email: email,
            password: password,
            profileImage: _selectedImage,
            name: name,
          );
          LoginController.clearText();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Registered as $email")));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ProductMobileScreen()),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Logged in as $email"),
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              behavior: SnackBarBehavior.floating,
              content: Text(TextClass.pleaseEnterEmailPassword),
            ),
          );
          LoginController.registerNameController.clear();
          LoginController.registerPasswordController.clear();
          LoginController.registerEmailController.clear();
        }
      },
      child: Text(
        TextClass.register,
        style: TextStyle(
          fontSize: 18,
          color: AppColors.textColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
