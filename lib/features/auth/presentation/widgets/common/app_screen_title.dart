import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

class AppScreenTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const AppScreenTitle({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: sl<AppTextStyles>().semiBold(
            color: AppColors.neutral1,
            fontSize: appH(24),
          ),
        ),
        SizedBox(height: appH(8)),
        Text(
          subtitle,
          style: sl<AppTextStyles>().regular(
            color: AppColors.neutral4,
            fontSize: appH(16),
          ),
        ),
      ],
    );
  }
} 