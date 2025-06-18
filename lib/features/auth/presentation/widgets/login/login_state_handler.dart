import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uic_task/features/auth/presentation/screens/fill_bio_screen.dart';
import 'package:uic_task/service_locator.dart';

class LoginStateHandler extends StatelessWidget {
  final Widget child;

  const LoginStateHandler({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        final AppTextStyles textStyles = sl<AppTextStyles>();
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthAuthenticated) {
          CustomRouter.close();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Login Successful!',
                style: textStyles.regular(
                  color: AppColors.white,
                  fontSize: 14,
                ),
              ),
              backgroundColor: AppColors.success,
            ),
          );

          CustomRouter.go(const FillBioScreen());
        } else if (state is AuthError) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: textStyles.regular(
                  color: AppColors.white,
                  fontSize: 14,
                ),
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: child,
    );
  }
} 