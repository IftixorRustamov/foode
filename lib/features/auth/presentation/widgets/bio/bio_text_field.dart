import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';
import 'package:uic_task/core/common/constants/strings/app_strings.dart';

class BioTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final TextInputType? keyboardType;
  final int? maxLines;

  const BioTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.keyboardType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: appH(8),
      children: [
        Text(
          label == AppStrings.fullName ? AppStrings.fullName :
          label == AppStrings.nickName ? AppStrings.nickName :
          label == AppStrings.phoneNumber ? AppStrings.phoneNumber :
          label,
          style: sl<AppTextStyles>().semiBold(
            color: AppColors.neutral1,
            fontSize: 16,
          ),
        ),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint == 'Enter your full name' ? AppStrings.enterFullName :
                      hint == 'Enter your nickname' ? AppStrings.enterNickName :
                      hint == 'Enter your phone number' ? AppStrings.enterPhoneNumber :
                      hint,
            hintStyle: sl<AppTextStyles>().semiBold(
              color: AppColors.black,
              fontSize: 14,
            ),
            filled: true,
            fillColor: AppColors.neutral9,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(100),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: appW(24),
              vertical: appH(12),
            ),
          ),
        ),
      ],
    );
  }
}
