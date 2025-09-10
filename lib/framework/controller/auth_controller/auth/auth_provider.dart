import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shopping_web_app/framework/controller/cart/cart_provider.dart';
import 'package:shopping_web_app/framework/controller/product/products_provider.dart';
import 'package:shopping_web_app/framework/repository/auth_repository/model/auth_model.dart';

import 'login_controller.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthModel?>(
  (ref) => AuthNotifier(ref),
);

class AuthNotifier extends StateNotifier<AuthModel?> {
  final Ref ref;

  AuthNotifier(this.ref) : super(null) {
    _loadAuthData();
  }

  // Load current user info if exists in it
  Future<void> _loadAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user_data');
    final isLogin = prefs.getBool('isLogin') ?? false;

    if (userJson != null && isLogin) {
      final userMap = jsonDecode(userJson);
      final user = AuthModel.fromJson(userMap);
      state = user.copyWith(isLogin: true);
    }
  }

  // Registering a new user and save his info to list
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    File? profileImage,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    // Get existing users
    final usersJson = prefs.getString('registered_users');
    List<dynamic> usersList = usersJson != null ? jsonDecode(usersJson) : [];

    // Checking if the user already exists
    bool userExists = usersList.any((user) => user['email'] == email);
    if (userExists) {
      throw Exception('User already exists with this email');
    }

    final newUser = AuthModel(
      name: name,
      email: email,
      password: password,
      isLogin: false,
      isGuest: false,
      profileImage: profileImage,
    );

    // Add new user
    usersList.add(newUser.toJson());
    await prefs.setString('registered_users', jsonEncode(usersList));

    // Saving current user information
    await prefs.setString('user_data', jsonEncode(newUser.toJson()));
    await prefs.setString('userEmail', email);
    await prefs.setBool('isRegistered', true);
    await cartService.saveUserEmail(email);
    state = newUser;
    ref.read(categoryFilterProvider.notifier).state = null;
  }

  // Log in with email and password
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('registered_users');

    if (usersJson != null) {
      final usersList = jsonDecode(usersJson) as List;
      for (final userMap in usersList) {
        final user = AuthModel.fromJson(Map<String, dynamic>.from(userMap));
        if (user.email == email && user.password == password) {
          final updatedUser = user.copyWith(isLogin: true, isGuest: false);

          await prefs.setString('user_data', jsonEncode(updatedUser.toJson()));
          await prefs.setBool('isLogin', true);
          await prefs.setString('userEmail', email);

          await cartService.saveUserEmail(email);

          state = updatedUser;
          ref.read(categoryFilterProvider.notifier).state = null;
          return true;
        }
      }
    }

    return false;
  }

  // Guest login with dummy name and values
  Future<void> loginAsGuest() async {
    final prefs = await SharedPreferences.getInstance();

    final guestUser = AuthModel(
      name: 'Guest',
      email: '',
      password: '',
      isLogin: true,
      isGuest: true,
      profileImage: null,
    );

    await prefs.setString('user_data', jsonEncode(guestUser.toJson()));
    await prefs.setBool('isLogin', true);
    await prefs.remove('userEmail');
    state = guestUser;
    ref.read(categoryFilterProvider.notifier).state = null;
  }

  //Logout current user but keep registered users in it
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear only current session
    await prefs.remove('user_data');
    await prefs.remove('isLogin');
    await prefs.remove('userEmail');

    state = null;
    ref.read(categoryFilterProvider.notifier).state = null;
    LoginController.clearText();
  }

  // list of all registered users
  Future<List<AuthModel>> getRegisteredUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final usersJson = prefs.getString('registered_users');
    if (usersJson == null) return [];

    final usersList = jsonDecode(usersJson) as List;
    return usersList
        .map((e) => AuthModel.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }
}

final passwordVisibilityProvider = StateProvider<bool>((ref) => true);
