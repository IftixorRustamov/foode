import 'package:flutter/material.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../../core/common/constants/colors/app_colors.dart';
import '../../../../../core/common/textstyles/app_textstyles.dart';

class SocialLoginButtons extends StatelessWidget {
  const SocialLoginButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppColors.neutral7, width: 1),
              ),
              foregroundColor: AppColors.neutral1,
            ),
            icon: const Icon(Icons.facebook, color: Color(0xFF1877F2)),
            // Facebook icon
            label: Text(
              'Facebook',
              style: textStyles.medium(color: AppColors.neutral1, fontSize: 16),
            ),
          ),
        ),
        const SizedBox(width: 16), // Spacing between buttons
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: AppColors.neutral7, width: 1),
              ),
              foregroundColor: AppColors.neutral1,
            ),
            icon: Image.asset(
              'assets/images/google.png',
              height: appH(25),
              width: appW(25),
            ),
            label: Text(
              'Google',
              style: textStyles.medium(color: AppColors.black, fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
