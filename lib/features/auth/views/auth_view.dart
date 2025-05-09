import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validation_utils.dart';
import '../../home/presentation/home_screen.dart';
import '../models/auth_model.dart';
import '../widgets/auth_button.dart';
import '../widgets/custom_text_field.dart';
import '../controllers/auth_controller.dart';
import '../widgets/custom_snackbar.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with SingleTickerProviderStateMixin {
  bool isLogin = false;
  late AnimationController _controller;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleAuth() async {
    if (_formKey.currentState!.validate()) {
      final controller = context.read<AuthController>();
      final model = AuthModel(email: _emailController.text, password: _passwordController.text);

      if (isLogin) {
        await controller.signin(model);
      } else {
        await controller.signup(model);
      }

      if (controller.isSuccess) {
        if (!mounted) return;

        if (!isLogin) {
          // Show success message for signup
          CustomSnackBar.show(
            context: context,
            message: 'Registration successful! Please login to continue.',
            isSuccess: true,
          );

          // Clear the form
          _emailController.clear();
          _passwordController.clear();

          // Switch to login view with animation
          setState(() {
            isLogin = true;
            _controller.reverse();
          });

          // Show login instructions
          Future.delayed(const Duration(seconds: 1), () {
            if (!mounted) return;
            CustomSnackBar.show(
              context: context,
              message: 'Please login with your new credentials',
              isSuccess: true,
              duration: const Duration(seconds: 2),
            );
          });
        } else {
          // Navigate to home screen after successful login
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
      } else if (controller.error != null) {
        // Show error message
        CustomSnackBar.show(
          context: context,
          message: controller.error!,
          isSuccess: false,
        );
      }
    }
  }

  void _handleGoogleAuth() async {
    final controller = context.read<AuthController>();
    await controller.signinWithGoogle();

    if (controller.isSuccess) {
      if (!mounted) return;

      // Navigate to home screen after successful Google sign-in
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthController>(
      builder: (context, controller, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
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
                    CustomTextField(
                      label: 'Email',
                      icon: Icons.email_outlined,
                      controller: _emailController,
                      validator: ValidationUtils.validateEmail,
                    ).animate().fadeIn(delay: 300.ms, duration: 400.ms).slideX(begin: 20, end: 0, duration: 500.ms),
                    const SizedBox(height: 16),
                    CustomTextField(
                      label: 'Password',
                      icon: Icons.lock_outline,
                      isPassword: true,
                      controller: _passwordController,
                      validator: ValidationUtils.validatePassword,
                    ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideX(begin: 20, end: 0, duration: 500.ms),
                    const SizedBox(height: 24),
                    AuthButton(
                      onPressed: _handleAuth,
                      text: isLogin ? 'Sign In' : 'Sign Up',
                      isLoading: controller.isLoading,
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
                      onPressed: _handleGoogleAuth,
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
                            style: const TextStyle(color: AppTheme.primaryColor),
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 800.ms, duration: 400.ms),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
