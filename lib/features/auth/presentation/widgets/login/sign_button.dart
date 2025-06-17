// lib/features/auth/presentation/widgets/login/sign_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart'; // Absolute path
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart'; // For appH()
import 'package:uic_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../../core/common/textstyles/app_textstyles.dart';

// This is the new SignInButton, using the DefaultButton's visual style.
class SignInButton extends StatelessWidget {
  final VoidCallback onPressed;

  const SignInButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          height: appH(55), // Using appH for responsiveness
          child: ElevatedButton(
            onPressed: state is AuthLoading ? null : onPressed,
            // Disable when loading
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary, // Uses AppColors.primary
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  25,
                ), // Rounded corners from DefaultButton
              ),
              elevation: 0, // No shadow
            ),
            child: state is AuthLoading
                ? const CircularProgressIndicator(color: AppColors.white)
                : Text(
                    'Sign In', // Text for the button
                    style: textStyles.semiBold(
                      color: AppColors.white,
                      fontSize: 18,
                    ),
                  ),
          ),
        );
      },
    );
  }
}
