// import 'package:flutter/material.dart';
// import 'package:iconly/iconly.dart';
// import 'package:kursol/core/utils/responsiveness/app_responsive.dart';
// import '../../../di/service_locator.dart';
// import '../../constants/colors/app_colors.dart';
// import '../../textstyles/source_san_textstyles.dart';
//
// class ActionAppBarWg extends StatelessWidget implements PreferredSizeWidget {
//   const ActionAppBarWg({
//     super.key,
//     this.titleText,
//     required this.onBackPressed,
//     this.actions,
//   });
//
//   final String? titleText;
//   final VoidCallback onBackPressed;
//   final List<Widget>? actions;
//
//   @override
//   Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//
//   @override
//   Widget build(BuildContext context) {
//     return AppBar(
//       backgroundColor: AppColors.white,
//       elevation: 0,
//       scrolledUnderElevation: 0,
//       centerTitle: false,
//       title: Text(
//         titleText ?? "",
//         style: sl<UrbanistTextStyles>().bold(
//           color: AppColors.black,
//           fontSize: 24,
//         ),
//       ),
//       leading: IconButton(
//         onPressed: onBackPressed,
//         icon: Icon(
//           IconlyLight.arrow_left,
//           size: appH(28),
//           color: AppColors.black,
//         ),
//       ),
//       actions: actions,
//       flexibleSpace: Container(
//         decoration: BoxDecoration(
//           color: AppColors.white,
//
//         ),
//       ),
//     );
//   }
// }
