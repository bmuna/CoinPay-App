import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/auth_button.dart';
import '../widgets/custom_text_field.dart';
import '../../home/presentation/home_screen.dart';
import '../../../core/theme/app_theme.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with SingleTickerProviderStateMixin {
  bool isLogin = true;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: Hero(
                  tag: 'app_title',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      'CoinPay',
                      style: GoogleFonts.poppins(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ),
              ).animate().slideY(
                    begin: -0.2,
                    end: 0,
                    curve: Curves.easeOutQuart,
                    duration: 800.ms,
                  ),
              const SizedBox(height: 40),
              Text(
                isLogin ? 'Welcome Back' : 'Create Account',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideX(begin: -20, end: 0, duration: 500.ms),
              const SizedBox(height: 8),
              Text(
                isLogin ? 'Sign in to continue using CoinPay' : 'Sign up to start your crypto journey',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.grey[400],
                    ),
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideX(begin: -20, end: 0, duration: 500.ms),
              const SizedBox(height: 32),
              if (!isLogin)
                CustomTextField(
                  label: 'Full Name',
                  icon: Icons.person_outline,
                ).animate().fadeIn(delay: 200.ms, duration: 400.ms).slideX(begin: 20, end: 0, duration: 500.ms),
              if (!isLogin) const SizedBox(height: 16),
              CustomTextField(
                label: 'Email',
                icon: Icons.email_outlined,
              ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideX(begin: 20, end: 0, duration: 500.ms),
              const SizedBox(height: 16),
              CustomTextField(
                label: 'Password',
                icon: Icons.lock_outline,
                isPassword: true,
              ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideX(begin: 20, end: 0, duration: 500.ms),
              const SizedBox(height: 24),
              AuthButton(
                onPressed: () {
                  if (isLogin) {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: const Duration(milliseconds: 800),
                        pageBuilder: (context, animation, secondaryAnimation) => FadeTransition(
                          opacity: animation,
                          child: const HomeScreen(),
                        ),
                      ),
                    );
                  }
                },
                text: isLogin ? 'Sign In' : 'Sign Up',
              ).animate().fadeIn(delay: 500.ms, duration: 400.ms).slideY(begin: 20, end: 0, duration: 500.ms),
              const SizedBox(height: 24),
              Row(
                children: [
                  const Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'or continue with',
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ),
                  const Expanded(child: Divider(color: Colors.grey)),
                ],
              ).animate().fadeIn(delay: 600.ms, duration: 400.ms),
              const SizedBox(height: 24),
              AuthButton(
                onPressed: () {},
                text: isLogin ? 'Sign in with Google' : 'Sign up with Google',
                icon: 'assets/images/google_icon.png',
                isOutlined: true,
              ).animate().fadeIn(delay: 700.ms, duration: 400.ms).slideY(begin: 20, end: 0, duration: 500.ms),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isLogin ? "Don't have an account? " : 'Already have an account? ',
                    style: TextStyle(color: Colors.grey[400]),
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (isLogin) {
                          _controller.forward();
                        } else {
                          _controller.reverse();
                        }
                        isLogin = !isLogin;
                      });
                    },
                    child: Text(
                      isLogin ? 'Sign Up' : 'Sign In',
                      style: TextStyle(color: AppTheme.primaryColor),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 800.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }
}
