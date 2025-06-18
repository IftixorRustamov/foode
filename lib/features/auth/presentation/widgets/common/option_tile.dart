import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

class OptionTile extends StatelessWidget {
  final Widget leading;
  final bool selected;
  final VoidCallback onTap;
  final double height;
  final String? label;

  const OptionTile({
    super.key,
    required this.leading,
    required this.selected,
    required this.onTap,
    this.label,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: appH(height),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(appH(16)),
          border: Border.all(
            color: selected ? AppColors.primary : AppColors.neutral8,
            width: 2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neutral9.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: label == null
            ? Center(child: leading)
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  leading,
                  SizedBox(height: appH(10)),
                  Text(
                    label!,
                    style: sl<AppTextStyles>().semiBold(
                      color: AppColors.black,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
