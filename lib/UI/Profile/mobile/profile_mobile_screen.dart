import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Auth/mobile/auth/login_mobile_screen.dart';
import 'package:shopping_web_app/UI/utils/theme/text_class.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/login_controller.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';

class ProfileMobileScreen extends ConsumerWidget {
  const ProfileMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text(TextClass.profileLabel),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              if (user?.profileImage != null)
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: CircleAvatar(
                    radius: 110,
                    backgroundImage: FileImage(user!.profileImage!),
                  ),
                )
              else
                CircleAvatar(radius: 100, child: Icon(Icons.person, size: 40)),
              SizedBox(height: 16),
              Text('Name: ${user?.name}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 10),
              Text('Email: ${user?.email}', style: TextStyle(fontSize: 18)),
              SizedBox(height: 70),
              SizedBox(
                width: double.maxFinite,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginMobileScreen(),
                      ),
                      (route) => route.isCurrent,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        duration: Duration(milliseconds: 1000),
                        margin: EdgeInsets.only(bottom: 60),
                        behavior: SnackBarBehavior.floating,
                        content: Text(TextClass.logout),
                        backgroundColor: AppColors.successColor,
                      ),
                    );
                    LoginController.loginPasswordController.clear();
                    LoginController.loginEmailController.clear();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                  ),
                  child: Text(
                    TextClass.logout,
                    style: TextStyle(color: AppColors.textColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
