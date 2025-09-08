import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Auth/web/auth/register_web_screen.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import '../../../../framework/controller/auth_controller/auth/login_controller.dart';
import '../../../../framework/provider/auth/auth_provider.dart';
import '../../../Product/web/product_web_screen.dart';

class LoginWebScreen extends ConsumerStatefulWidget {
  const LoginWebScreen({super.key});

  @override
  ConsumerState<LoginWebScreen> createState() => _LoginWebScreenState();
}

class _LoginWebScreenState extends ConsumerState<LoginWebScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final authNotifier = ref.read(authProvider.notifier);
    final obscurePassword = ref.watch(passwordVisibilityProvider);

    // final width = MediaQuery.of(context).size.width;
    // final formWidth = width < 400 ? width : width;
    String? validateEmail(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email cannot be empty';
      }
      String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$';
      RegExp regex = RegExp(pattern);
      if (!regex.hasMatch(value)) {
        return 'Enter valid email address';
      }
      return null;
    }

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                  controller: LoginController.emailController,
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
                  controller: LoginController.passwordController,
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
                      final email = LoginController.emailController.text.trim();
                      final password = LoginController.passwordController.text
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
                              behavior: SnackBarBehavior.floating,
                              backgroundColor: AppColors.successColor,
                            ),
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductWebScreen(),
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
                            backgroundColor: AppColors.successColor,
                            content: Text(TextClass.pleaseEnterEmailPassword),
                          ),
                        );
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
                        builder: (context) => RegisterWebScreen(),
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
                InkWell(
                  onTap: () async {
                    await authNotifier.loginAsGuest();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProductWebScreen(),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: TextStyle(color: AppColors.textColor),
                      children: [
                        TextSpan(text: TextClass.loginAs),
                        TextSpan(
                          text: TextClass.guest,
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
