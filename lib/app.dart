import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/providers/theme_provider.dart';
import 'package:laundry_app/core/providers/auth_provider.dart';
import 'routes.dart';

class LaundryApp extends StatelessWidget {
  const LaundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Laundry Pro',
          theme: AppColors.lightTheme,
          darkTheme: AppColors.darkTheme,
          themeMode: themeProvider.themeMode,
          initialRoute: AppRoutes.home,
          onGenerateRoute: AppRoutes.generateRoute,
        );
      },
    );
  }
}
