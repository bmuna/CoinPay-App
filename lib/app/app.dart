import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../features/home/presentation/home_screen.dart';
import '../core/theme/app_theme.dart';
import '../features/splash/splash_screen.dart';

class CoinPayApp extends StatelessWidget {
  const CoinPayApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Force dark status bar
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
      ),
    );

    return MaterialApp(
      title: 'CoinPay',
      theme: AppTheme.darkTheme, // Force dark theme
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark, // Force dark mode
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
