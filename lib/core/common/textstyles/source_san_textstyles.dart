import 'package:uic_task/core/common/constants/font_family.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';

import 'app_textstyles.dart';
import 'package:flutter/material.dart';

class SourceSanTextStyles extends AppTextStyles {
  @override
  TextStyle bold({required Color color, required double fontSize}) => TextStyle(
    fontSize: AppResponsive.height(fontSize),
    color: color,
    fontWeight: FontWeight.bold,
    fontFamily: FontFamily.sourceSan,
  );

  @override
  TextStyle semiBold({required Color color, required double fontSize}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        color: color,
        fontWeight: FontWeight.w600,
        fontFamily: FontFamily.sourceSan,
      );

  @override
  TextStyle medium({required Color color, required double fontSize}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        color: color,
        fontWeight: FontWeight.w500,
        fontFamily: FontFamily.sourceSan,
      );

  @override
  TextStyle regular({required Color color, required double fontSize}) =>
      TextStyle(
        fontSize: AppResponsive.height(fontSize),
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: FontFamily.sourceSan,
      );
}
