import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/constants/sizes.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/home/presentation/screens/home_screen.dart';
import 'package:uic_task/features/home/presentation/widgets/bottom_nav_bar.dart';
import 'package:uic_task/service_locator.dart';
import '../../../../core/common/textstyles/app_textstyles.dart';

class CongratsScreen extends StatefulWidget {
  const CongratsScreen({super.key});

  @override
  State<CongratsScreen> createState() => _CongratsScreenState();
}

class _CongratsScreenState extends State<CongratsScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        CustomRouter.go(const HomeScreen());
      }
    });
  }

  void _goHome() {
    CustomRouter.go(const BottomNavBar());
  }

  @override
  Widget build(BuildContext context) {
    final textStyles = sl<AppTextStyles>();
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: btm48,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: appW(120),
                      height: appW(120),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            AppColors.primary.withOpacity(0.7),
                            AppColors.primary,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    Icon(Icons.check, size: appW(64), color: Colors.white),
                  ],
                ),
                SizedBox(height: appH(32)),
                Text(
                  'Congrats!',
                  style: textStyles.bold(
                    color: AppColors.primary,
                    fontSize: 28,
                  ),
                ),
                SizedBox(height: appH(16)),
                Text(
                  'Your profile is ready to use',
                  style: textStyles.regular(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Spacer(),
                DefaultButton(text: 'Go homepage', onPressed: _goHome),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
