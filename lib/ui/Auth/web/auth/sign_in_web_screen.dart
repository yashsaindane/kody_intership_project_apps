import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopping_web_app/ui/product/web/product_web_screen.dart';

import '../../../../framework/controller/auth_controller/auth/auth_provider.dart';
import '../../../../framework/controller/auth_controller/auth/login_controller.dart';
import '../../../utils/theme/app_colors.dart';
import '../../../utils/theme/text_class.dart';

class SignInWebScreen extends ConsumerWidget {
  const SignInWebScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    File? _selectedImage;
    Future<void> _pickImage(ImageSource source) async {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
        });
      }
    }

    final authNotifier = ref.read(authProvider.notifier);
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
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
                      backgroundImage: CachedNetworkImageProvider(
                        'https://www.pngfind.com/pngs/m/610-6104451_image-placeholder-png-user-Profile-placeholder-image-png.png',
                      ),
                    ),
                    Positioned(
                      left: 150,
                      top: 155,
                      child: InkWell(
                        onTap: () {
                          _pickImage(ImageSource.gallery);
                          Navigator.of(context).pop();
                        },
                        child: Icon(Icons.add_a_photo),
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
                  controller: LoginController.nameController,
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
                const SizedBox(height: 10),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    }
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  controller: LoginController.passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: TextClass.passwordLabel,
                    suffixIcon: Icon(Icons.remove_red_eye),
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
                      final email = LoginController.emailController.text.trim();
                      final password = LoginController.passwordController.text
                          .trim();
                      if (email.isNotEmpty && password.isNotEmpty) {
                        await authNotifier.login(email, password);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Logged in as $email"),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ProductWebScreen(),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            content: Text(TextClass.pleaseEnterEmailPassword),
                          ),
                        );
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

  setState(Null Function() param0) {}
}
