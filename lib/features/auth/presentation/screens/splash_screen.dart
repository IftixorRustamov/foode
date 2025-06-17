import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:uic_task/core/common/constants/constants_export.dart';
import 'package:uic_task/core/common/textstyles/source_san_textstyles.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/screens/splash_action_screen.dart';
import 'package:uic_task/service_locator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SplashLightScreen2()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: SvgPicture.asset(
              "assets/images/splash_backg.svg",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: appH(140),
                  width: appW(140),
                ),
                Text(
                  AppStrings.appName,
                  style: sl<SourceSanTextStyles>().semiBold(
                    color: AppColors.primary,
                    fontSize: 44,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
