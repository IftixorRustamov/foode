// lib/features/auth/presentation/widgets/login/sign_button.dart

import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/service_locator.dart';
import 'package:uic_task/core/common/constants/strings/app_strings.dart';

class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;

  const SignInButton({
    super.key,
    required this.onPressed,
    this.label = AppStrings.signIn,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Text(
          label,
          style: sl<AppTextStyles>().semiBold(
            color: AppColors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
