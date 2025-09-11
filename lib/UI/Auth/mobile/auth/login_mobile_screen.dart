import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Auth/mobile/auth/helper/custom_login_mobile_elevated.dart';
import 'package:shopping_web_app/UI/Auth/mobile/auth/register_mobile_screen.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/login_controller.dart';
import 'package:shopping_web_app/ui/product/mobile/product_mobile_screen.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import '../../../../framework/repository/auth_repository/contract/login_validator.dart';
import 'helper/custom_login_textformfield.dart';

class LoginMobileScreen extends ConsumerStatefulWidget {
  const LoginMobileScreen({super.key});

  @override
  ConsumerState<LoginMobileScreen> createState() => _LoginMobileScreenState();
}

class _LoginMobileScreenState extends ConsumerState<LoginMobileScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final authNotifier = ref.read(authProvider.notifier);
    // final width = MediaQuery.of(context).size.width;
    // final formWidth = width < 400 ? width : width;

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.only(top: 180, left: 15, right: 15),
          child: Center(
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    TextClass.login,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textColor,
                    ),
                  ),
                  const SizedBox(height: 60),
                  CustomTextFormFieldLogin(
                    controller: LoginController.loginEmailController,
                    labelText: TextClass.emailLabel,
                    hintText: TextClass.enterYourEmail,
                    prefixIcon: Icons.email,
                    validator: validateEmail,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFormFieldLogin(
                    controller: LoginController.loginPasswordController,
                    labelText: TextClass.passwordLabel,
                    hintText: TextClass.enterYourPassword,
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    visibilityProvider: passwordVisibilityProvider,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TextClass.pleaseEnterPassword;
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: CustomLoginMobileElevated(),
                  ),
                  const SizedBox(height: 15),
                  InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterMobileScreen(),
                        ),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        style: TextStyle(color: AppColors.textColor),
                        children: [
                          TextSpan(text: TextClass.donthaveAccount),
                          TextSpan(
                            text: TextClass.register,
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    TextClass.or,
                    style: TextStyle(color: AppColors.textColor, fontSize: 14),
                  ),
                  SizedBox(height: 20),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: AppColors.textColor),
                      children: [
                        TextSpan(text: TextClass.loginAs),
                        WidgetSpan(
                          child: InkWell(
                            onTap: () {
                              authNotifier.loginAsGuest();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ProductMobileScreen(),
                                ),
                              );
                            },
                            child: Text(
                              TextClass.guest,
                              style: TextStyle(color: AppColors.primaryColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
