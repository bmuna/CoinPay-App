import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class AuthButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final String? icon;
  final bool isOutlined;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.icon,
    this.isOutlined = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined ? Colors.transparent : AppTheme.primaryColor,
          foregroundColor: isOutlined ? AppTheme.primaryColor : Colors.white,
          elevation: isOutlined ? 0 : 1,
          shadowColor: isOutlined ? Colors.transparent : AppTheme.primaryColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: isOutlined
                ? const BorderSide(
                    color: AppTheme.primaryColor,
                    width: 1.5,
                  )
                : BorderSide.none,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            else ...[
              if (icon != null) ...[
                Image.asset(
                  icon!,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 12),
              ],
              Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
