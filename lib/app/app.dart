import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_theme.dart';
import '../features/splash/splash_screen.dart';
import '../features/auth/controllers/auth_controller.dart';

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

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthController()),
      ],
      child: MaterialApp(
        title: 'CoinPay',
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.dark, // Force dark mode
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
