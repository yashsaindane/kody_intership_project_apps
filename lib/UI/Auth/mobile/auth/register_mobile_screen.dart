import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/auth_provider.dart';
import 'package:shopping_web_app/framework/controller/auth_controller/auth/login_controller.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';
import 'package:shopping_web_app/ui/utils/theme/text_class.dart';

import '../../../Product/mobile/product_mobile_screen.dart';
import 'login_mobile_screen.dart';

class RegisterMobileScreen extends ConsumerStatefulWidget {
  const RegisterMobileScreen({super.key});

  @override
  ConsumerState<RegisterMobileScreen> createState() =>
      _RegisterMobileScreenState();
}

class _RegisterMobileScreenState extends ConsumerState<RegisterMobileScreen> {
  File? _selectedImage;

  Future<void> _pickImage(ImageSource gallery) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    // final width = MediaQuery.of(context).size.width;
    // final formWidth = width < 400 ? width * 0.9 : 400.0;
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

    final authNotifier = ref.read(authProvider.notifier);
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
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundImage: _selectedImage != null
                          ? FileImage(_selectedImage!)
                          : null,
                      backgroundColor: Colors.grey.shade200,
                      child: _selectedImage == null
                          ? Icon(Icons.person, size: 60, color: Colors.grey)
                          : null,
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () async {
                          await _pickImage(ImageSource.gallery);
                        },
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: AppColors.backgroundColor,
                          child: Icon(
                            Icons.add_a_photo,
                            color: AppColors.textColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 50),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  controller: LoginController.registerNameController,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: TextClass.name,
                    labelText: TextClass.enterYourName,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.person_2_outlined),
                  ),
                ),
                SizedBox(height: 10),
                TextFormField(
                  validator: validateEmail,
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  controller: LoginController.registerEmailController,
                  decoration: InputDecoration(
                    labelText: TextClass.emailLabel,
                    hintText: TextClass.enterYourEmail,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return TextClass.pleaseEnterPassword;
                    }
                    return null;
                  },
                  controller: LoginController.registerPasswordController,
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
                const SizedBox(height: 30),
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
                      final name = LoginController.registerNameController.text
                          .trim();
                      final email = LoginController.registerEmailController.text
                          .trim();
                      final password = LoginController
                          .registerPasswordController
                          .text
                          .trim();
                      if (email.isNotEmpty && password.isNotEmpty) {
                        await authNotifier.registerUser(
                          email: email,
                          password: password,
                          profileImage: _selectedImage,
                          name: name,
                        );
                        LoginController.clearText();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Registered as $email")),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductMobileScreen(),
                          ),
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
                  ),
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
