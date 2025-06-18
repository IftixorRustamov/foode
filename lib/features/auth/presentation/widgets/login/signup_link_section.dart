import 'package:flutter/material.dart';
import 'package:uic_task/core/common/textstyles/source_san_textstyles.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../../core/common/constants/colors/app_colors.dart';
import '../../../../../core/common/textstyles/app_textstyles.dart';

class SignUpLinkSection extends StatelessWidget {
  const SignUpLinkSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<SourceSanTextStyles>();
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Don't have an account? ",
            style: textStyles.regular(color: AppColors.neutral5, fontSize: 16),
          ),
          GestureDetector(
            onTap: () {
              CustomRouter.go(SignUpScreen());
            },
            child: Text(
              'Sign up',
              style: textStyles.semiBold(
                color: AppColors.primary,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
