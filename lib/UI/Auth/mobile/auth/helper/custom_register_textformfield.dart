import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextFormFieldRegister extends ConsumerWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final String? Function(String?)? validator;
  final StateProvider<bool>? visibilityProvider;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const CustomTextFormFieldRegister({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.validator,
    this.visibilityProvider,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isObscured = isPassword && visibilityProvider != null
        ? !ref.watch(visibilityProvider!)
        : false;

    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: isObscured,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(prefixIcon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        suffixIcon: isPassword && visibilityProvider != null
            ? InkWell(
                onTap: () {
                  ref.read(visibilityProvider!.notifier).state = !ref.read(
                    visibilityProvider!,
                  );
                },
                child: Icon(
                  ref.watch(visibilityProvider!)
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
              )
            : null,
      ),
    );
  }
}
