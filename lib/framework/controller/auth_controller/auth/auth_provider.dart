import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repository/auth_repository/model/auth_model.dart';
import 'login_controller.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthModel?>(
  (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthModel?> {
  AuthNotifier() : super(null) {
    _loadAuthData();
  }

  /// Load current user session if exists
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

  /// Register a new user and save to list
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

    // Check if user already exists
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

    // Save current user session (optional at this point)
    await prefs.setString('user_data', jsonEncode(newUser.toJson()));
    await prefs.setString('userEmail', email);
    await prefs.setBool('isRegistered', true);

    state = newUser;
  }

  /// Log in with email and password
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

          state = updatedUser;
          return true;
        }
      }
    }

    return false;
  }

  /// Guest login (no account)
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
  }

  //Logout current user, but keep registered users
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    // Clear only current session
    await prefs.remove('user_data');
    await prefs.remove('isLogin');
    await prefs.remove('userEmail');

    state = null;
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

// this provider is used to handle the visibility of the password field
final passwordVisibilityProvider = StateProvider<bool>((ref) => true);

///
// final registerNameProvider = StateProvider<String>((ref) => '');
// final registerEmailProvider = StateProvider<String>((ref) => '');
// final registerPasswordProvider = StateProvider<String>((ref) => '');
final registerProfileImageProvider = StateProvider<File?>((ref) => null);
