import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/common/constants/colors/app_colors.dart';
import 'package:uic_task/core/common/textstyles/app_textstyles.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uic_task/features/auth/presentation/screens/fill_bio_screen.dart';
import 'package:uic_task/service_locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uic_task/features/auth/presentation/screens/payment_method_screen.dart';

class LoginStateHandler extends StatelessWidget {
  final Widget child;

  const LoginStateHandler({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        final AppTextStyles textStyles = sl<AppTextStyles>();
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthAuthenticated) {

          await Future.delayed(const Duration(milliseconds: 200));
          final currentState = BlocProvider.of<AuthBloc>(context).state;
          if (currentState is AuthAuthenticated) {
            CustomRouter.close();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Login Successful!',
                  style: textStyles.regular(
                    color: AppColors.white,
                    fontSize: 14,
                  ),
                ),
                backgroundColor: AppColors.success,
              ),
            );
            // Check Firestore for profile info
            final uid = currentState.user.uid;
            final userDoc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
            final data = userDoc.data();
            print('Firestore user data: ' + (data?.toString() ?? 'null'));
            final hasProfile = data != null &&
              data['fullName'] != null && data['fullName'].toString().isNotEmpty &&
              data['nickName'] != null && data['nickName'].toString().isNotEmpty &&
              data['phoneNumber'] != null && data['phoneNumber'].toString().isNotEmpty &&
              data['gender'] != null && data['gender'].toString().isNotEmpty &&
              data['dateOfBirth'] != null &&
              data['address'] != null && data['address'].toString().isNotEmpty;
            print('Has profile: ' + hasProfile.toString());
            if (hasProfile) {
              CustomRouter.go(const PaymentMethodScreen());
            } else {
              CustomRouter.go(const FillBioScreen());
            }
          }
          // If state changed to AuthUnauthenticated, do nothing (user deleted or signed out)
        } else if (state is AuthError) {
          if (Navigator.canPop(context)) {
            Navigator.of(context).pop();
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.message,
                style: textStyles.regular(
                  color: AppColors.white,
                  fontSize: 14,
                ),
              ),
              backgroundColor: AppColors.error,
            ),
          );
        }
      },
      child: child,
    );
  }
} 