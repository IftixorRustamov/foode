import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';
import 'package:uic_task/core/common/constants/strings/app_strings.dart';

import 'email_input_field.dart';
import 'password_input_field.dart';
import 'remember_me_forgot_password_row.dart';
import 'sign_button.dart';

class LoginForm extends StatefulWidget {
  final void Function(String email, String password) onSubmit;

  const LoginForm({super.key, required this.onSubmit});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    // No credential loading
  }

  void _onLoginButtonPressed() {
    if (_formKey.currentState!.validate()) {
      widget.onSubmit(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
    }
  }

  void _onRememberMeChanged(bool newValue) {
    setState(() {
      _rememberMe = newValue;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
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
              return null;
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
            onRememberMeChanged: _onRememberMeChanged,
            initialValue: _rememberMe,
          ),
          SignInButton(onPressed: _onLoginButtonPressed),
          GestureDetector(
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
    );
  }
}
