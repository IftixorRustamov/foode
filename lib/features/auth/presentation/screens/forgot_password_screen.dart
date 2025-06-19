import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uic_task/features/auth/presentation/widgets/forgot_password/contact_option_tile.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String? selectedOption;
  bool _isLoading = false;

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
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            String? userEmail;
            if (state is AuthAuthenticated) {
              userEmail = state.user.email;
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select which contact details should we use to reset your password',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: AppColors.neutral4),
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
                  value: userEmail != null && userEmail.isNotEmpty
                      ? _maskEmail(userEmail)
                      : 'No email found',
                  isSelected: selectedOption == 'email',
                  onTap: () => setState(() => selectedOption = 'email'),
                ),
                const Spacer(),
                DefaultButton(
                  onPressed: _isLoading || selectedOption == null
                      ? null
                      : () async {
                          if (selectedOption == 'email' && userEmail != null && userEmail.isNotEmpty) {
                            setState(() => _isLoading = true);
                            try {
                              await FirebaseAuth.instance.sendPasswordResetEmail(email: userEmail);
                              if (mounted) {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Check your email'),
                                    content: const Text('A password reset link has been sent to your email address.'),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          CustomRouter.close();
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            } on FirebaseAuthException catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e.message ?? 'Failed to send reset email.'),
                                  backgroundColor: AppColors.error,
                                ),
                              );
                            } finally {
                              if (mounted) setState(() => _isLoading = false);
                            }
                          } else if (selectedOption == 'sms') {
                            // TODO: Implement SMS reset if needed
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('SMS reset is not implemented.'),
                                backgroundColor: AppColors.error,
                              ),
                            );
                          }
                        },
                  text: _isLoading ? 'Sending...' : 'Next',
                ),
                SizedBox(height: appH(16)),
              ],
            );
          },
        ),
      ),
    );
  }

  String _maskEmail(String email) {
    final parts = email.split('@');
    if (parts.length != 2) return email;
    final name = parts[0];
    final domain = parts[1];
    if (name.length <= 2) return email;
    final maskedName =
        name[0] + '*' * (name.length - 2) + name[name.length - 1];
    return '$maskedName@$domain';
  }
}
