import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/UI/Auth/mobile/auth/helper/custom_register_mobile_elevated.dart';
import 'package:shopping_web_app/UI/Auth/mobile/auth/helper/custom_register_stack.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/login_controller.dart';
import 'package:shopping_web_app/framework/repository/auth_repository/contract/validator.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import 'helper/custom_register_textformfield.dart';
import 'login_mobile_screen.dart';

class RegisterMobileScreen extends ConsumerStatefulWidget {
  const RegisterMobileScreen({super.key});

  @override
  ConsumerState<RegisterMobileScreen> createState() =>
      _RegisterMobileScreenState();
}

class _RegisterMobileScreenState extends ConsumerState<RegisterMobileScreen> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    // final width = MediaQuery.of(context).size.width;
    // final formWidth = width < 400 ? width * 0.9 : 400.0;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginMobileScreen()),
              );
            },
            child: Icon(Icons.arrow_back),
          ),
          toolbarHeight: 30,
          backgroundColor: AppColors.backgroundColor,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(top: 100, left: 15, right: 15),
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  TextClass.register,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textColor,
                  ),
                ),
                SizedBox(height: 20),
                CustomRegisterStack(),
                const SizedBox(height: 50),
                CustomTextFormFieldRegister(
                  controller: LoginController.registerNameController,
                  labelText: TextClass.enterYourName,
                  hintText: TextClass.name,
                  prefixIcon: Icons.person_2_outlined,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                CustomTextFormFieldRegister(
                  controller: LoginController.registerEmailController,
                  labelText: TextClass.emailLabel,
                  hintText: TextClass.enterYourEmail,
                  prefixIcon: Icons.email,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                ),
                const SizedBox(height: 10),
                CustomTextFormFieldRegister(
                  controller: LoginController.registerPasswordController,
                  labelText: TextClass.passwordLabel,
                  hintText: TextClass.enterYourPassword,
                  prefixIcon: Icons.lock,
                  isPassword: true,
                  visibilityProvider: passwordVisibilityProvider,
                  textInputAction: TextInputAction.done,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return TextClass.pleaseEnterPassword;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: CustomRegisterMobileElevated(),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
