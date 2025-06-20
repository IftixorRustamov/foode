import 'package:flutter/material.dart';
import '../../../../service_locator.dart';
import '../../../utils/responsiveness/app_responsive.dart';
import '../../constants/colors/app_colors.dart';
import '../../textstyles/source_san_textstyles.dart';

class ActionAppBarWg extends StatelessWidget implements PreferredSizeWidget {
  const ActionAppBarWg({
    super.key,
    this.titleText,
    required this.onBackPressed,
    this.actions,
  });

  final String? titleText;
  final VoidCallback onBackPressed;
  final List<Widget>? actions;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.pink.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                size: appH(16),
                color: AppColors.primary,
              ),
              onPressed: onBackPressed,
            ),
          ),
          SizedBox(width: appW(16)),
          Text(
            titleText ?? "",
            style: sl<SourceSanTextStyles>().bold(
              color: AppColors.black,
              fontSize: 24,
            ),
          ),
        ],
      ),
      // leading: IconButton(
      //   onPressed: onBackPressed,
      //   icon: Icon(
      //     IconlyLight.arrow_left,
      //     size: appH(28),
      //     color: AppColors.primary,
      //   ),
      // ),
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(color: AppColors.white),
      ),
    );
  }
}
