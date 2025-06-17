// lib/features/auth/presentation/widgets/auth_heading.dart

import 'package:flutter/material.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../../core/common/constants/colors/app_colors.dart';
import '../../../../../core/common/textstyles/app_textstyles.dart';

class AuthHeading extends StatelessWidget {
  final String title;

  const AuthHeading({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();
    return Text(
      title,
      style: textStyles.semiBold(color: AppColors.neutral1, fontSize: 23),
      textAlign: TextAlign.center,
    );
  }
}
