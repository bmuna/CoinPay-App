import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class WalletCard extends StatelessWidget {
  const WalletCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      child: Container(
        height: 200,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppTheme.primaryColor,
              AppTheme.accentColor,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Total Balance',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ).animate(delay: 400.ms).fadeIn(duration: 400.ms).slideX(begin: -20, end: 0, duration: 500.ms),
            const SizedBox(height: 8),
            Text(
              '\$10,234.56',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ).animate(delay: 500.ms).fadeIn(duration: 400.ms).slideX(begin: -20, end: 0, duration: 500.ms),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'BTC Balance',
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      '0.2345 BTC',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ).animate(delay: 600.ms).fadeIn(duration: 400.ms).slideX(begin: -20, end: 0, duration: 500.ms),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.currency_bitcoin,
                    color: Colors.white,
                  ),
                ).animate(delay: 700.ms).fadeIn(duration: 400.ms).scale(
                      begin: const Offset(0, 0),
                      end: const Offset(1, 1),
                      curve: Curves.easeOutBack,
                      duration: 600.ms,
                    ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
