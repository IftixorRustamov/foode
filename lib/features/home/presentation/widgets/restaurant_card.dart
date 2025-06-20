import 'package:flutter/material.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/textstyles/app_textstyles.dart';
import '../../../../core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

class RestaurantCard extends StatelessWidget {
  final String iconPath;
  final String title;
  final String time;

  const RestaurantCard(this.iconPath, this.title, this.time, {super.key});

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();

    return Container(
      width: 150,
      padding: EdgeInsets.all(18),
      margin: EdgeInsets.only(right: 4),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Image.network(iconPath, height: appH(60)),
          SizedBox(height: appH(12)),
          Text(
            title,
            style: textStyles.semiBold(fontSize: 16, color: AppColors.black),
          ),
          Text(
            time,
            style: textStyles.regular(color: AppColors.neutral4, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
