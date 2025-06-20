import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/common/constants/constants_export.dart';
import 'package:uic_task/core/common/constants/sizes.dart';
import 'package:uic_task/core/common/widgets/app_bar/action_app_bar_wg.dart';
import 'package:uic_task/core/common/widgets/button/default_button.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/screens/payment_method_screen.dart';
import 'package:uic_task/service_locator.dart';

import '../../../../core/common/textstyles/app_textstyles.dart';
import '../bloc/auth_bloc.dart';
import '../widgets/bio/bio_text_field.dart';
import '../widgets/bio/date_picker_field.dart';
import '../widgets/bio/gender_dropdown_field.dart';
import 'package:uic_task/core/common/constants/strings/app_strings.dart';

class FillBioScreen extends StatefulWidget {
  const FillBioScreen({super.key});

  @override
  State<FillBioScreen> createState() => _FillBioScreenState();
}

class _FillBioScreenState extends State<FillBioScreen> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _nickNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  DateTime? _dateOfBirth;
  String? _selectedGender;

  @override
  void dispose() {
    _fullNameController.dispose();
    _nickNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (_validateFields()) {
      final authBloc = sl<AuthBloc>();
      final currentState = authBloc.state;

      if (currentState is AuthAuthenticated) {
        authBloc.add(
          AuthUpdateBioEvent(
            uid: currentState.user.uid,
            fullName: _fullNameController.text,
            nickName: _nickNameController.text,
            phoneNumber: _phoneController.text,
            gender: _selectedGender ?? '',
            dateOfBirth: _dateOfBirth ?? DateTime.now(),
            address: _addressController.text,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please sign in again to update your profile.'),
            backgroundColor: AppColors.error,
          ),
        );
        return;
      }
    }
  }

  bool _validateFields() {
    if (_fullNameController.text.isEmpty ||
        _nickNameController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _selectedGender == null ||
        _dateOfBirth == null ||
        _addressController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields'),
          backgroundColor: AppColors.error,
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: sl<AuthBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        appBar: ActionAppBarWg(
          onBackPressed: () => CustomRouter.close(),
          titleText: "Fill your bio",
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );
            } else if (state is AuthBioUpdated) {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
              CustomRouter.go(const PaymentMethodScreen());
            } else if (state is AuthError) {
              if (Navigator.canPop(context)) {
                Navigator.of(context).pop();
              }
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: AppColors.error,
                ),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: btm48,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: appH(24),
                children: [
                  Text(
                    AppStrings.displayedInProfile,
                    style: sl<AppTextStyles>().semiBold(
                      color: AppColors.neutral1,
                      fontSize: 16,
                    ),
                  ),
                  Column(
                    spacing: appH(20),
                    children: [
                      BioTextField(
                        controller: _fullNameController,
                        label: AppStrings.fullName,
                        hint: AppStrings.enterFullName,
                      ),
                      BioTextField(
                        controller: _nickNameController,
                        label: AppStrings.nickName,
                        hint: AppStrings.enterNickName,
                      ),
                      BioTextField(
                        controller: _phoneController,
                        label: AppStrings.phoneNumber,
                        hint: AppStrings.enterPhoneNumber,
                        keyboardType: TextInputType.phone,
                      ),
                      GenderDropdownField(
                        value: _selectedGender,
                        onChanged: (value) {
                          setState(() {
                            _selectedGender = value;
                          });
                        },
                      ),
                      DatePickerField(
                        selectedDate: _dateOfBirth,
                        onDateSelected: (date) {
                          setState(() {
                            _dateOfBirth = date;
                          });
                        },
                      ),
                      BioTextField(
                        controller: _addressController,
                        label: 'Address',
                        hint: 'Enter your address',
                        maxLines: 1,
                      ),
                      DefaultButton(
                        text: AppStrings.next,
                        onPressed: _onNextPressed,
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
