import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/common/constants/sizes.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
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

  void _onRememberMeChanged(bool newValue) {
    print('Remember Me status: $newValue');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          final AppTextStyles textStyles = sl<AppTextStyles>();
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Login Successful!',
                  style: textStyles.regular(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
                backgroundColor:
                    AppColors.success, // Use AppColors.successGreen
              ),
            );
            // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => const HomePage()));
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
                backgroundColor: AppColors.error, // Use AppColors.errorRed
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: btm48,
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: appH(90),
                  width: appW(90),
                ),
                const AuthHeading(title: 'Sign in to your account'),
                EmailInputField(
                  controller: _emailController,
                  // Removed helperText and helperTextColor properties
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email cannot be empty'; // This message will be displayed as errorText
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email address'; // This message will be displayed as errorText
                    }
                    return null; // No error
                  },
                ),
                PasswordInputField(
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password cannot be empty';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                RememberMeForgotPasswordRow(
                  onRememberMeChanged: _onRememberMeChanged,
                ),
                SignInButton(onPressed: _onLoginButtonPressed),
                GestureDetector(
                  child: Text(
                    "Forgot the password?",
                    style: sl<AppTextStyles>().semiBold(
                      color: AppColors.primary,
                      fontSize: 16,
                    ),
                  ),
                ),
                const OrDivider(),
                const SocialLoginButtons(),
                const SizedBox(height: 40),
                const SignUpLinkSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
