import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/constants_export.dart';
import 'package:uic_task/core/common/textstyles/source_san_textstyles.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/screens/login_screen.dart';
import 'package:uic_task/service_locator.dart';

class SplashLightScreen2 extends StatelessWidget {
  const SplashLightScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/splash_action.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: AppColors.black,
                child: const Center(
                  child: Text(
                    'Image Load Error',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.0),
                    Colors.black.withOpacity(0.7),
                  ],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: appW(24),
                  vertical: appH(48),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.appName,
                      style: sl<SourceSanTextStyles>().bold(
                        color: AppColors.white,
                        fontSize: 33,
                      ),
                    ),
                    Text(
                      'The best food ordering and delivery app of the century.',
                      style: sl<SourceSanTextStyles>().semiBold(
                        color: AppColors.white,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 40),
                    DefaultButton(
                      text: AppStrings.next,
                      onPressed: () {
                        CustomRouter.open(LoginScreen());
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
