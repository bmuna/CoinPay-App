import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../widgets/wallet_card.dart';
import '../widgets/transaction_list.dart';
import '../widgets/payment_terminal.dart';
import '../../../core/theme/app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBackground,
      appBar: AppBar(
        backgroundColor: AppTheme.darkSurfaceColor,
        elevation: 0,
        title: Hero(
          tag: 'app_title',
          child: Material(
            color: Colors.transparent,
            child: Text(
              'CoinPay',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.white),
            onPressed: () {},
          )
              .animate(delay: 400.ms)
              .fadeIn(duration: 400.ms, curve: Curves.easeInOut)
              .slideX(begin: 15, end: 0, curve: Curves.easeOutQuint, duration: 600.ms),
          const SizedBox(width: 8),
        ],
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const WalletCard()
                      .animate(delay: 100.ms)
                      .fadeIn(duration: 600.ms, curve: Curves.easeInOut)
                      .slideY(begin: 20, end: 0, curve: Curves.easeOutQuint, duration: 800.ms)
                      .scale(
                          begin: const Offset(0.97, 0.97), end: const Offset(1, 1), curve: Curves.easeOutExpo, duration: 800.ms),
                  const SizedBox(height: 24),
                  const Text(
                    "Recent Transactions",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate(delay: 300.ms).fadeIn(duration: 400.ms).slideX(begin: -20, end: 0, duration: 500.ms),
                  const SizedBox(height: 12),
                  const TransactionList()
                      .animate(delay: 400.ms)
                      .fadeIn(duration: 600.ms, curve: Curves.easeInOut)
                      .slideY(begin: 30, end: 0, curve: Curves.easeOutQuint, duration: 800.ms),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => const PaymentTerminal(),
          );
        },
        icon: const Icon(Icons.contactless),
        label: const Text('Pay'),
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      )
          .animate(delay: 600.ms)
          .fadeIn(duration: 600.ms, curve: Curves.easeInOut)
          .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), curve: Curves.easeOutBack, duration: 800.ms),
    );
  }
}
