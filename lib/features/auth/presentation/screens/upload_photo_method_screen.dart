import 'package:flutter/material.dart';
import 'package:uic_task/core/common/constants/constants_export.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/screens/upload_photo_preview_screen.dart';
import '../../../../core/common/textstyles/app_textstyles.dart';
import '../../../../service_locator.dart';
import '../widgets/common/option_tile.dart';

class UploadPhotoMethodScreen extends StatefulWidget {
  const UploadPhotoMethodScreen({super.key});

  @override
  State<UploadPhotoMethodScreen> createState() =>
      _UploadPhotoMethodScreenState();
}

class _UploadPhotoMethodScreenState extends State<UploadPhotoMethodScreen> {
  int? _selectedIndex;

  void _onNext() {
    CustomRouter.go(UploadPhotoPreviewScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(onBackPressed: CustomRouter.close),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: appW(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: appH(24),
            children: [
              Text(
                'This data will be displayed in your account profile for security',
                style: sl<AppTextStyles>().regular(
                  color: AppColors.black,
                  fontSize: 16,
                ),
              ),
              OptionTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(appH(16)),
                  child: Icon(
                    Icons.camera_alt,
                    color: AppColors.primary,
                    size: appH(32),
                  ),
                ),
                label: 'Take photo',
                selected: _selectedIndex == 0,
                onTap: () => setState(() => _selectedIndex = 0),
                height: appH(160),
              ),
              OptionTile(
                leading: Container(
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(appH(16)),
                  child: Icon(
                    Icons.folder,
                    color: AppColors.primary,
                    size: appH(32),
                  ),
                ),
                label: 'From gallery',
                selected: _selectedIndex == 1,
                onTap: () => setState(() => _selectedIndex = 1),
                height: appH(160),
              ),
              const Spacer(),
              DefaultButton(
                text: AppStrings.next,
                onPressed: _selectedIndex != null ? _onNext : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
