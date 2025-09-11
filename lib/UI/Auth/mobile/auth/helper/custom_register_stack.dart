import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../framework/repository/auth_repository/contract/image_helper.dart';
import '../../../../utils/theme/app_colors.dart';

class CustomRegisterStack extends ConsumerStatefulWidget {
  const CustomRegisterStack({super.key});

  @override
  ConsumerState<CustomRegisterStack> createState() =>
      _CustomRegisterStackState();
}

class _CustomRegisterStackState extends ConsumerState<CustomRegisterStack> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
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
              final image = await ImageHelper.pickImage(ImageSource.gallery);
              if (image != null) {
                setState(() {
                  _selectedImage = image;
                });
              }
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: AppColors.backgroundColor,
              child: Icon(Icons.add_a_photo, color: AppColors.textColor),
            ),
          ),
        ),
      ],
    );
  }
}
