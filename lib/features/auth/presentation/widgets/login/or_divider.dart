import 'package:flutter/material.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../../core/common/constants/colors/app_colors.dart';
import '../../../../../core/common/textstyles/app_textstyles.dart';

class OrDivider extends StatelessWidget {
  const OrDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'or continue with',
            style: textStyles.regular(color: AppColors.black, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
