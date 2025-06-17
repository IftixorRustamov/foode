import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart'; // Absolute path
import 'package:uic_task/core/common/widgets/custom_text_field.dart'; // Absolute path for custom_text_field
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../../core/common/textstyles/app_textstyles.dart';

class EmailInputField extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const EmailInputField({super.key, required this.controller, this.validator});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: appH(8),
      children: [
        Text(
          'Email*',
          style: textStyles.medium(color: AppColors.neutral1, fontSize: 16),
        ),
        CustomTextField(
          controller: controller,
          hintText: 'Email or Phone Number',
          keyboardType: TextInputType.emailAddress,
          validator: validator,
        ),
      ],
    );
  }
}
