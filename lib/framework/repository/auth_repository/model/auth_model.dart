import 'dart:io';

class AuthModel {
  final String name;
  final String email;
  final String password;
  final bool isLogin;
  final bool isGuest;
  final File? profileImage;

  AuthModel({
    required this.name,
    required this.email,
    required this.password,
    this.isLogin = false,
    this.isGuest = false,
    this.profileImage,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'email': email,
    'password': password,
    'isLogin': isLogin,
    'isGuest': isGuest,
    'profileImagePath': profileImage?.path,
  };

  factory AuthModel.fromJson(Map<String, dynamic> json) => AuthModel(
    name: json['name'] ?? '',
    email: json['email'] ?? '',
    password: json['password'] ?? '',
    isLogin: json['isLogin'] ?? false,
    isGuest: json['isGuest'] ?? false,
    profileImage: json['profileImagePath'] != null
        ? File(json['profileImagePath'])
        : null,
  );

  AuthModel copyWith({
    String? name,
    String? email,
    String? password,
    bool? isLogin,
    bool? isGuest,
    File? profileImage,
  }) {
    return AuthModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isLogin: isLogin ?? this.isLogin,
      isGuest: isGuest ?? this.isGuest,
      profileImage: profileImage ?? this.profileImage,
    );
  }
}

List<AuthModel> authInfo = [];
