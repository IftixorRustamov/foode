import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/constants_export.dart';
import 'package:uic_task/core/common/constants/sizes.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/screens/upload_photo_method_screen.dart';
import '../../../../service_locator.dart';
import '../widgets/common/option_tile.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _selectedIndex = 0;
  final List<String> _methods = [
    'assets/images/paypal.png',
    'assets/images/visa.png',
    'assets/images/payoneer.png',
  ];

  void _onNext() {
    CustomRouter.go(UploadPhotoMethodScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(
        onBackPressed: () => CustomRouter.close(),
        titleText: "Payment method",
      ),
      body: SafeArea(
        child: Padding(
          padding: btm48,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: appH(24),
            children: [
              Text(
                "This data will be displayed in your account profile for security",
                style: sl<AppTextStyles>().regular(
                  color: AppColors.black,
                  fontSize: 16,
                ),
              ),
              ...List.generate(
                _methods.length,
                (i) => Padding(
                  padding: EdgeInsets.only(bottom: appH(16)),
                  child: OptionTile(
                    leading: Image.asset(_methods[i], height: appH(32)),
                    selected: _selectedIndex == i,
                    onTap: () => setState(() => _selectedIndex = i),
                    height: 64,
                  ),
                ),
              ),
              const Spacer(),
              DefaultButton(text: AppStrings.next, onPressed: _onNext),
            ],
          ),
        ),
      ),
    );
  }
}
