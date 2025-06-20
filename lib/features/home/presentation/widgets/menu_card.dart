import 'package:flutter/material.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/service_locator.dart';

class FoodCard extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;

  const FoodCard({
    super.key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 9, offset: Offset(0, 2)),
        ],
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imagePath,
              height: appH(50),
              width: appW(50),
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: appW(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: textStyles.semiBold(
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: appH(4)),
                Text(
                  subtitle,
                  style: textStyles.regular(
                    color: AppColors.neutral1,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "\$$price",
            style: textStyles.semiBold(fontSize: 26, color: Colors.redAccent),
          ),
        ],
      ),
    );
  }
}
