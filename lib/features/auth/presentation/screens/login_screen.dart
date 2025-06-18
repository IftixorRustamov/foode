import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/sizes.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../core/common/constants/colors/app_colors.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/login/auth_heading.dart';
import '../widgets/login/login_form.dart';
import '../widgets/login/login_state_handler.dart';
import '../widgets/login/or_divider.dart';
import '../widgets/login/signup_link_section.dart';
import '../widgets/login/social_login_buttons.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void _handleLogin(String email, String password) {
    sl<AuthBloc>().add(
      AuthSignInEvent(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: LoginStateHandler(
        child: SingleChildScrollView(
          padding: btm48,
          child: Column(
            spacing: appH(32),
            children: [
              Image.asset(
                "assets/images/logo.png",
                height: appH(90),
                width: appW(90),
              ),
              const AuthHeading(title: 'Sign in to your account'),
              LoginForm(onSubmit: _handleLogin),
              Column(
                spacing: appH(24),
                children: [
                  const OrDivider(),
                  const SocialLoginButtons(),
                ],
              ),
              const SignUpLinkSection(),
            ],
          ),
        ),
      ),
    );
  }
}
