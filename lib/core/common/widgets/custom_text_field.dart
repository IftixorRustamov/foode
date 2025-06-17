// lib/core/common/widgets/custom_text_field.dart

import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart'; // Absolute path
import 'package:uic_task/service_locator.dart';

import '../textstyles/app_textstyles.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final String? helperText;
  final Color? helperTextColor;
  final Widget? prefixIcon; // Allow custom prefix icon

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.helperText,
    this.helperTextColor,
    this.prefixIcon, // Pass prefix icon
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _isObscure;

  @override
  void initState() {
    super.initState();
    _isObscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();

    return TextFormField(
      controller: widget.controller,
      obscureText: _isObscure,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      style: textStyles.regular(color: AppColors.neutral1, fontSize: 16),
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: textStyles.regular(color: AppColors.neutral5, fontSize: 16),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16.0,
          horizontal: 20.0,
        ),
        fillColor: AppColors.neutral8,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 1.5,
          ), // Changed to AppColors.primary
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 1.5,
          ), // Changed to AppColors.error
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(
            color: AppColors.error,
            width: 2.0,
          ), // Changed to AppColors.error
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                  color: AppColors.neutral4,
                ),
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : widget.suffixIcon,
        helperText: widget.helperText,
        helperStyle: textStyles.regular(
          color: widget.helperTextColor ?? AppColors.neutral3,
          fontSize: 12,
        ),
        prefixIcon: widget.prefixIcon,
        // Use the passed prefixIcon
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
      ),
    );
  }
}
