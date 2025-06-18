import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:uic_task/features/auth/presentation/widgets/forgot_password/contact_option_tile.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? selectedOption;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(
        onBackPressed: () => CustomRouter.close(),
        titleText: "Forgot password?",
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select which contact details should we use to reset your password',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppColors.neutral4,
                  ),
            ),
            SizedBox(height: appH(32)),
            ContactOptionTile(
              icon: Icons.message,
              label: 'via SMS:',
              value: '+6282*****39',
              isSelected: selectedOption == 'sms',
              onTap: () => setState(() => selectedOption = 'sms'),
            ),
            SizedBox(height: appH(20)),
            ContactOptionTile(
              icon: Icons.email_outlined,
              label: 'via Email:',
              value: 'ex***le@yourdomain.com',
              isSelected: selectedOption == 'email',
              onTap: () => setState(() => selectedOption = 'email'),
            ),
            const Spacer(),
            DefaultButton(
              onPressed: selectedOption != null
                  ? () => CustomRouter.go(const ResetPasswordScreen())
                  : null,
              text: 'Next',
            ),
            SizedBox(height: appH(16)),
          ],
        ),
      ),
    );
  }
} 