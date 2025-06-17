import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/service_locator.dart';

class AppTheme {
  const AppTheme._();

  static ThemeData lightTheme() {
    final AppTextStyles textStyles = sl<AppTextStyles>();

    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.white,
      fontFamily: textStyles
          .regular(color: Colors.black, fontSize: 16)
          .fontFamily,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.neutral1,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textStyles.semiBold(
          color: AppColors.neutral1,
          fontSize: 24,
        ),
      ),
      textTheme:
          TextTheme(
            displayLarge: textStyles.bold(
              color: AppColors.neutral1,
              fontSize: 48,
            ),
            // For large headings
            displayMedium: textStyles.bold(
              color: AppColors.neutral1,
              fontSize: 34,
            ),
            displaySmall: textStyles.semiBold(
              color: AppColors.neutral1,
              fontSize: 28,
            ),
            // Other main headings
            headlineMedium: textStyles.semiBold(
              color: AppColors.neutral1,
              fontSize: 20,
            ),
            // Subheadings
            bodyLarge: textStyles.regular(
              color: AppColors.neutral2,
              fontSize: 18,
            ),
            // Larger body text
            bodyMedium: textStyles.regular(
              color: AppColors.neutral3,
              fontSize: 16,
            ),
            // Default body text
            bodySmall: textStyles.regular(
              color: AppColors.neutral4,
              fontSize: 14,
            ),
            // Smaller body text
            labelLarge: textStyles.semiBold(
              color: AppColors.white,
              fontSize: 18,
            ), // Button text style
          ).apply(
            bodyColor: AppColors.neutral1, // Default text color for body
            displayColor: AppColors.neutral1, // Default text color for headings
          ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          textStyle: textStyles.semiBold(color: AppColors.white, fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  static ThemeData darkTheme() {
    final AppTextStyles textStyles = sl<AppTextStyles>();

    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.dark2,
      fontFamily: textStyles
          .regular(color: Colors.white, fontSize: 16)
          .fontFamily,

      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: textStyles.semiBold(
          color: AppColors.white,
          fontSize: 24,
        ),
      ),
      textTheme: TextTheme(
        displayLarge: textStyles.bold(color: AppColors.white, fontSize: 48),
        displayMedium: textStyles.bold(color: AppColors.white, fontSize: 34),
        displaySmall: textStyles.semiBold(color: AppColors.white, fontSize: 28),
        headlineMedium: textStyles.semiBold(
          color: AppColors.white,
          fontSize: 20,
        ),
        bodyLarge: textStyles.regular(color: AppColors.neutral7, fontSize: 18),
        bodyMedium: textStyles.regular(color: AppColors.neutral6, fontSize: 16),
        bodySmall: textStyles.regular(color: AppColors.neutral5, fontSize: 14),
        labelLarge: textStyles.semiBold(
          color: AppColors.white,
          fontSize: 18,
        ), // Button text style
      ).apply(bodyColor: AppColors.white, displayColor: AppColors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          textStyle: textStyles.semiBold(color: AppColors.white, fontSize: 18),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
      ),
      // Add other common theme properties
    );
  }
}
