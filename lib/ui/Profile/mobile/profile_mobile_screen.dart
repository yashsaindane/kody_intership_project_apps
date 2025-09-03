import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shopping_web_app/ui/Auth/mobile/auth/auth_mobile_screen.dart';
import 'package:shopping_web_app/ui/utils/theme/app_colors.dart';

import '../../../framework/controller/auth_controller/auth/auth_provider.dart';

class ProfileMobileScreen extends ConsumerWidget {
  const ProfileMobileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await authNotifier.logout();

              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => AuthMobileScreen()),
                );
              }
            },
          ),
        ],
      ),
      body: user == null
          ? Center(child: Text('No user data available'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  children: [
                    if (user.profileImage != null)
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: CircleAvatar(
                          radius: 90,
                          backgroundImage: FileImage(user.profileImage!),
                        ),
                      )
                    else
                      CircleAvatar(
                        radius: 90,
                        child: Icon(Icons.person, size: 40),
                      ),
                    SizedBox(height: 16),
                    Text('Name: ${user.name}', style: TextStyle(fontSize: 18)),
                    SizedBox(height: 10),
                    Text(
                      'Email: ${user.email}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 8),
                  ],
                ),
              ),
            ),
    );
  }
}
