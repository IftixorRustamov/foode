import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/common/theme/app_theme.dart';
import 'package:uic_task/core/common/theme/bloc/theme_bloc.dart';
import 'package:uic_task/core/routes/custom_router.dart';
import 'package:uic_task/core/utils/responsiveness/app_responsive.dart';
import 'package:uic_task/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:uic_task/features/auth/presentation/screens/splash_screen.dart';
import 'package:uic_task/features/home/presentation/widgets/bottom_nav_bar.dart';

import 'features/orders/presentation/bloc/cart_bloc.dart';
import 'features/orders/presentation/bloc/order_history_cubit.dart';
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
        BlocProvider<CartBloc>(create: (context) => CartBloc()),
        BlocProvider<OrderHistoryCubit>(create: (context) => OrderHistoryCubit()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, themeState) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: CustomRouter.navigatorKey,
            theme: AppTheme.lightTheme(),
            darkTheme: AppTheme.darkTheme(),
            themeMode: themeState.themeMode,
            home: SplashScreen(),
          );
        },
      ),
    );
  }
}
