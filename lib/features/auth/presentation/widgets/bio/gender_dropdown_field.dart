import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/common/textstyles/source_san_textstyles.dart';
import 'package:uic_task/service_locator.dart';

class GenderDropdownField extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const GenderDropdownField({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender*',
          style: sl<SourceSanTextStyles>().semiBold(
            color: AppColors.neutral1,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: AppColors.neutral9,
            borderRadius: BorderRadius.circular(12),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              hint: Text(
                'Select gender',
                style: sl<AppTextStyles>().semiBold(
                  color: AppColors.neutral5,
                  fontSize: 14,
                ),
              ),
              items: ['Male', 'Female', 'Other']
                  .map(
                    (gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(
                        gender,
                        style: sl<AppTextStyles>().semiBold(
                          color: AppColors.neutral1,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
