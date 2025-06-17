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
              padding: EdgeInsets.symmetric(
                vertical: appH(16),
                horizontal: appW(24),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(width: 1, color: AppColors.white),
              ),
              foregroundColor: AppColors.neutral1,
            ),
            icon: Image.asset(
              'assets/images/facebook.png',
              height: appH(25),
              width: appW(25),
            ),
            // Facebook icon
            label: Text(
              'Facebook',
              style: textStyles.medium(color: AppColors.neutral1, fontSize: 16),
            ),
          ),
        ),
        SizedBox(width: appW(16)),
        Expanded(
          child: OutlinedButton.icon(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                vertical: appH(16),
                horizontal: appW(24),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(color: AppColors.white, width: 1),
              ),
              foregroundColor: AppColors.white,
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
