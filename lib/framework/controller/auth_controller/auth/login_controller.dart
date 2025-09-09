import 'package:flutter/cupertino.dart';

class LoginController {
  static final TextEditingController loginEmailController =
      TextEditingController();
  static final TextEditingController loginPasswordController =
      TextEditingController();
  static final TextEditingController registerNameController =
      TextEditingController();
  static final TextEditingController registerEmailController =
      TextEditingController();
  static final TextEditingController registerPasswordController =
      TextEditingController();

  static void clearText() {
    loginEmailController.clear();
    loginPasswordController.clear();
    registerPasswordController.clear();
    registerEmailController.clear();
    registerNameController.clear();
  }

  void dispose() {
    loginEmailController.dispose();
    loginPasswordController.dispose();
    registerNameController.dispose();
    registerEmailController.dispose();
    registerPasswordController.dispose();
  }
}
