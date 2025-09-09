import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Auth/mobile/auth/register_mobile_screen.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/login_controller.dart';
import 'package:shopping_web_app/ui/product/mobile/product_mobile_screen.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

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
    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return TextClass.emailCannotBeEmpty;
      }
      String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        return TextClass.enterValidEmailAddress;
      }
      return null;
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
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
                  TextFormField(
                    validator: validateEmail,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: LoginController.loginEmailController,
                    decoration: InputDecoration(
                      labelText: TextClass.emailLabel,
                      hintText: TextClass.enterYourEmail,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.email),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return TextClass.pleaseEnterPassword;
                      }
                      return null;
                    },
                    controller: LoginController.loginPasswordController,
                    obscureText: !ref.watch(passwordVisibilityProvider),
                    decoration: InputDecoration(
                      suffixIcon: InkWell(
                        onTap: () {
                          ref.read(passwordVisibilityProvider.notifier).state =
                              !ref.read(passwordVisibilityProvider);
                        },
                        child: Icon(
                          ref.watch(passwordVisibilityProvider)
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                      ),
                      labelText: TextClass.passwordLabel,
                      hintText: TextClass.enterYourPassword,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      prefixIcon: Icon(Icons.lock),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.secondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      onPressed: () async {
                        final email = LoginController.loginEmailController.text
                            .trim();
                        final password = LoginController
                            .loginPasswordController
                            .text
                            .trim();
                        if (email.isNotEmpty && password.isNotEmpty) {
                          final success = await authNotifier.login(
                            email,
                            password,
                          );
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
                              MaterialPageRoute(
                                builder: (context) => ProductMobileScreen(),
                              ),
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
                    ),
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
                        //
                        // TextSpan(
                        //   text: TextClass.guest,
                        //   style: TextStyle(color: AppColors.primaryColor),
                        // ),
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
