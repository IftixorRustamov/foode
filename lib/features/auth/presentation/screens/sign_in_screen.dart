import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/common/constants/sizes.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/screens/fill_bio_screen.dart';
import 'package:uic_task/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../../../../core/common/textstyles/app_textstyles.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login/auth_heading.dart';
import '../widgets/login/email_input_field.dart';
import '../widgets/login/or_divider.dart';
import '../widgets/login/password_input_field.dart';
import '../widgets/login/remember_me_forgot_password_row.dart';
import '../widgets/login/sign_button.dart';
import '../widgets/login/signup_link_section.dart';
import '../widgets/login/social_login_buttons.dart';
import 'package:uic_task/core/common/constants/strings/app_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      sl<AuthBloc>().add(
        AuthSignInEvent(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.padding.top;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final AppTextStyles textStyles = sl<AppTextStyles>();
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  AppStrings.loginSuccessful,
                  style: textStyles.regular(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
                backgroundColor: AppColors.success,
              ),
            );
            CustomRouter.open(FillBioScreen());
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message,
                  style: textStyles.regular(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: btm48,
          child: Form(
            key: _formKey,
            child: Column(
              spacing: appH(32),
              children: [
                SizedBox(height: topPadding + 16),
                Image.asset(
                  "assets/images/logo.png",
                  height: appH(90),
                  width: appW(90),
                ),
                const AuthHeading(title: 'Sign in to your account'),
                Column(
                  spacing: appH(20),
                  children: [
                    EmailInputField(
                      controller: _emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.emailCannotBeEmpty;
                        }
                        if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                          return AppStrings.enterValidEmail;
                        }
                        return null; // No error
                      },
                    ),
                    PasswordInputField(
                      controller: _passwordController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return AppStrings.passwordCannotBeEmpty;
                        }
                        if (value.length < 6) {
                          return AppStrings.passwordMinLength;
                        }
                        return null;
                      },
                    ),
                    RememberMeForgotPasswordRow(
                      onRememberMeChanged: (value) {},
                    ),
                    SignInButton(onPressed: _onLoginButtonPressed),
                    GestureDetector(
                      onTap: () => CustomRouter.go(ForgotPasswordScreen()),
                      child: Text(
                        AppStrings.forgotPassword,
                        style: sl<AppTextStyles>().semiBold(
                          color: AppColors.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  spacing: appH(24),
                  children: [const OrDivider(), const SocialLoginButtons()],
                ),
                const SignUpLinkSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
