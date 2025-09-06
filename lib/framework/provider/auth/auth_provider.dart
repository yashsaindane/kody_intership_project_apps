import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../repository/auth_repository/model/auth_model.dart';

//this notifier is used to authenticated user.
final authProvider = StateNotifierProvider<AuthNotifier, AuthModel?>(
  (ref) => AuthNotifier(),
);

// this class handles the authentication state  like (login, logout, etc.)
class AuthNotifier extends StateNotifier<AuthModel?> {
  //Constructor initializes the state to null and loads user data on startup
  AuthNotifier() : super(null) {
    _loadAuthData(); // // Load user data
  }

  //this function loads the user data from SharedPreferences
  //If user data exists and is logged in, it updates the state
  Future<void> _loadAuthData() async {
    final prefs =
        await SharedPreferences.getInstance(); // gets the shared preference instance
    // Retrieve user data stored in local storage
    final userJson = prefs.getString('user_data');
    // Retrieve login status of the user
    final isLogin = prefs.getBool('isLogin') ?? false;

    if (userJson != null && isLogin) {
      // it decodes the JSON string to a map
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      // then converts the  map to AuthModel object
      final user = AuthModel.fromJson(userMap);
      state = user.copyWith(isLogin: true);
    }
  }

  // Here new user are register and there data is stored in SharedPreferences
  Future<void> registerUser({
    required String name,
    required String email,
    required String password,
    File? profileImage,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    final user = AuthModel(
      name: name,
      email: email,
      password: password,
      isLogin: false,
      profileImage: profileImage,
      isGuest: false,
    );

    // again converts to JSON
    final userJson = jsonEncode(user.toJson());
    // then saves to shared preference
    await prefs.setString('user_data', userJson);
    // it indicates that user is register
    await prefs.setBool('isRegistered', true);
    state = user;
  }

  // this function allows an existing user to log in.
  //It checks the saved user data and compares email/password to authenticate
  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    //reterive shared preference data
    final userJson = prefs.getString('user_data');

    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      final user = AuthModel.fromJson(userMap);

      //here the user email and password are matched
      if (user.email == email && user.password == password) {
        // if it matches it updates user as login and save it
        final updatedUser = user.copyWith(isLogin: true, isGuest: false);
        await prefs.setString('user_data', jsonEncode(updatedUser.toJson()));
        await prefs.setBool('isLogin', true);
        state = updatedUser;
        return true;
      }
    }
    //if login fails
    return false;
  }

  // here in this function user is login as Guest
  Future<void> loginAsGuest() async {
    final prefs = await SharedPreferences.getInstance();

    // dummy user is created named as guest
    final guestUser = AuthModel(
      name: "Guest",
      email: "",
      password: "",
      isLogin: true,
      profileImage: null,
      isGuest: true,
    );
    // dummy data is stored in shared preference
    await prefs.setString('user_data', jsonEncode(guestUser.toJson()));
    await prefs.setBool('isLogin', true);
    state = guestUser;
  }

  // this is logout function where the isLogin set to false
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    final userJson = prefs.getString('user_data');
    if (userJson != null) {
      final Map<String, dynamic> userMap = jsonDecode(userJson);
      userMap['isLogin'] = false;
      //here data is saved back to shared preference
      await prefs.setString('user_data', jsonEncode(userMap));
      await prefs.setBool('isLogin', false);
      final user = AuthModel.fromJson(userMap);
      state = user; // user logout state
    } else {
      state = null; // if no data to store then state is set to null
    }
  }
}

// this provider is used to handle the visibility of the password field
final passwordVisibilityProvider = StateProvider<bool>((ref) => true);
