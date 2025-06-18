import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
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
      backgroundColor: AppColors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      title: Text(
        titleText ?? "",
        style: sl<SourceSanTextStyles>().bold(
          color: AppColors.black,
          fontSize: 24,
        ),
      ),
      leading: IconButton(
        onPressed: onBackPressed,
        icon: Icon(
          IconlyLight.arrow_left,
          size: appH(28),
          color: AppColors.primary,
        ),
      ),
      actions: actions,
      flexibleSpace: Container(
        decoration: BoxDecoration(color: AppColors.white),
      ),
    );
  }
}
