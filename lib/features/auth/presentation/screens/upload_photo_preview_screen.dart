import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uic_task/core/common/constants/constants_export.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/screens/set_location_screen.dart';
import 'package:uic_task/service_locator.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../../core/common/textstyles/app_textstyles.dart';

class UploadPhotoPreviewScreen extends StatefulWidget {
  const UploadPhotoPreviewScreen({super.key});

  @override
  State<UploadPhotoPreviewScreen> createState() =>
      _UploadPhotoPreviewScreenState();
}

class _UploadPhotoPreviewScreenState extends State<UploadPhotoPreviewScreen> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _takePhotoWithCamera() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.camera,
    );

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
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
                  CustomRouter.close();
                  _pickImageFromGallery();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onNext(BuildContext context) async {
    if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a photo first.')),
      );
      return;
    }

    bool uploadSuccess = false;
    try {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      final fileName =
          'profile_photos/${DateTime.now().millisecondsSinceEpoch}_${_image!.path.split('/').last}';
      final ref = FirebaseStorage.instance.ref().child(fileName);
      final uploadTask = await ref.putFile(_image!);
      final downloadUrl = await uploadTask.ref.getDownloadURL();
      uploadSuccess = true;
    } catch (e) {
      print(e.toString());
    } finally {
      if (Navigator.canPop(context)) CustomRouter.close();
      CustomRouter.go(SetLocationScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: ActionAppBarWg(
        onBackPressed: CustomRouter.close,
        titleText: AppStrings.uploadYourPhoto,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: appW(24)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: appH(24),
            children: [
              Text(
                AppStrings.displayedInProfile,
                style: sl<AppTextStyles>().regular(
                  color: AppColors.neutral3,
                  fontSize: 16,
                ),
              ),
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: appH(72),
                      backgroundImage: _image != null
                          ? FileImage(_image!) as ImageProvider<Object>
                          : const AssetImage('assets/images/sample_avatar.jpg'),
                      backgroundColor:
                          AppColors.neutral7,
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
