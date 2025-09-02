import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../respository/auth_repository/model/auth_model.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthModel?>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthModel?> {
  AuthNotifier() : super(null) {
    _loadAuthData();
  }

  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_data');
    final isLogin = prefs.getBool('isLogin') ?? false;

    if (userJson != null && isLogin) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final user = AuthModel.fromJson(userMap);
      state = user.copyWith(isLogin: true);
    }
  }

  Future<void> registerUser({
    required String email,
    required String password,
    File? profileImage,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final user = AuthModel(
      email: email,
      password: password,
      isLogin: false,
      profileImage: profileImage,
    );

    final userJson = jsonEncode(user.toJson());
    await prefs.setString('user_data', userJson);
    await prefs.setBool('isRegistered', true);
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_data');

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final user = AuthModel.fromJson(userMap);

      if (user.email == email && user.password == password) {
        final updatedUser = user.copyWith(isLogin: true);
        await prefs.setString('user_data', jsonEncode(updatedUser.toJson()));
        await prefs.setBool('isLogin', true);
        state = updatedUser;
        return true;
      }
    }

    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    state = null;
  }

  bool get isLoggedIn => state?.isLogin == true;
}

final passwordVisibilityProvider = StateProvider<bool>((ref) => true);
