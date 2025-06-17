import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/common/theme/app_theme.dart';
import 'package:uic_task/core/common/theme/bloc/theme_bloc.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uic_task/features/auth/presentation/screens/splash_screen.dart';

import 'service_locator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppResponsive.init(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => sl<AuthBloc>()..add(AuthCheckStatusEvent()),
        ),
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            navigatorKey: CustomRouter.navigatorKey,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeState.themeMode,
            home: Builder(
              builder: (context) {
                return SplashScreen();
              },
            ),
          );
        },
      ),
    );
  }
}
