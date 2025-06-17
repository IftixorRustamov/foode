// lib/features/auth/presentation/widgets/login/password_input_field.dart

import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart'; // Absolute path
import 'package:uic_task/core/common/widgets/custom_text_field.dart'; // Absolute path
import 'package:uic_task/service_locator.dart';

import '../../../../../core/common/textstyles/app_textstyles.dart';

class PasswordInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PasswordInputField({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password*',
          style: textStyles.medium(color: AppColors.neutral1, fontSize: 16),
        ),
        const SizedBox(height: 8),
        CustomTextField(
          controller: controller,
          hintText: 'Password',
          obscureText: true,
          keyboardType: TextInputType.visiblePassword,
          validator:
              validator ??
              (value) {
                if (value == null || value.isEmpty) {
                  return 'Password cannot be empty';
                }
                if (value.length < 6) {
                  return 'Password must be at least 6 characters';
                }
                return null;
              },
        ),
      ],
    );
  }
}
