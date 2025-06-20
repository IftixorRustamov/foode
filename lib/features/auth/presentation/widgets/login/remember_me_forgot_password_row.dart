import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart'; // Absolute path
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../../core/common/textstyles/app_textstyles.dart';

class RememberMeForgotPasswordRow extends StatefulWidget {
  final ValueChanged<bool> onRememberMeChanged;
  final bool initialValue;

  const RememberMeForgotPasswordRow({
    super.key,
    required this.onRememberMeChanged,
    this.initialValue = false,
  });

  @override
  State<RememberMeForgotPasswordRow> createState() =>
      _RememberMeForgotPasswordRowState();
}

class _RememberMeForgotPasswordRowState
    extends State<RememberMeForgotPasswordRow> {
  late bool _rememberMe;

  @override
  void initState() {
    super.initState();
    _rememberMe = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = sl<AppTextStyles>();
    return Row(
      children: [
        SizedBox(
          width: appW(16),
          height: appH(16),
          child: Checkbox(
            value: _rememberMe,
            onChanged: (newValue) {
              setState(() {
                _rememberMe = newValue ?? false;
              });
              widget.onRememberMeChanged(_rememberMe);
            },
            activeColor: AppColors.primary,
            checkColor: AppColors.white,
            side: const BorderSide(color: AppColors.primary, width: 1.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        SizedBox(width: appW(12)),
        Text(
          'Remember me',
          style: textStyles.semiBold(color: AppColors.neutral1, fontSize: 14),
        ),
      ],
    );
  }
}
