import 'dart:io'; // Required for File

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import image_picker
import 'package:uic_task/core/common/constants/constants_export.dart'; // Assuming AppStrings is here
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../core/common/textstyles/app_textstyles.dart';

class UploadPhotoPreviewScreen extends StatefulWidget {
  const UploadPhotoPreviewScreen({super.key});

  @override
  State<UploadPhotoPreviewScreen> createState() =>
      _UploadPhotoPreviewScreenState();
}

class _UploadPhotoPreviewScreenState extends State<UploadPhotoPreviewScreen> {
  File? _image; // State variable to hold the picked image

  final ImagePicker _picker = ImagePicker(); // Instance of ImagePicker

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(
          pickedFile.path,
        ); // Update the state with the selected image
      });
    }
  }

  Future<void> _takePhotoWithCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(
          pickedFile.path,
        ); // Update the state with the captured image
      });
    }
  }

  void _onEditPhoto(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => SafeArea(
        child: Padding(
          padding: EdgeInsets.all(appH(24)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: Text(
                  'Take photo',
                  style: sl<AppTextStyles>().regular(
                    color: AppColors.neutral1,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _takePhotoWithCamera(); // Call camera function
                },
              ),
              ListTile(
                leading: const Icon(Icons.folder),
                title: Text(
                  'From gallery',
                  style: sl<AppTextStyles>().regular(
                    color: AppColors.neutral1,
                    fontSize: 16,
                  ),
                ),
                onTap: () {
                  Navigator.pop(context); // Close the bottom sheet
                  _pickImageFromGallery(); // Call gallery function
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onNext(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Next pressed! (Implement navigation)')),
    );
    if (_image != null) {
      print('Image path to upload: ${_image!.path}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(
        onBackPressed: CustomRouter.close,
        titleText: 'Upload your photo',
      ),
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
                  color: AppColors.neutral3,
                  // Adjusted color for better readability
                  fontSize: 16,
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: appH(72),
                      // Display picked image, otherwise default asset
                      backgroundImage: _image != null
                          ? FileImage(_image!) as ImageProvider<Object>
                          : const AssetImage('assets/images/sample_avatar.jpg'),
                      backgroundColor:
                          AppColors.neutral7, // Fallback background color
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: FloatingActionButton(
                        mini: true,
                        backgroundColor: AppColors.primary,
                        onPressed: () => _onEditPhoto(context),
                        child: const Icon(Icons.edit, color: AppColors.white),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              DefaultButton(
                text: AppStrings.next,
                onPressed: () => _onNext(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
