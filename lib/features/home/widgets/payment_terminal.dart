import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class PaymentTerminal extends StatefulWidget {
  const PaymentTerminal({super.key});

  @override
  State<PaymentTerminal> createState() => _PaymentTerminalState();
}

class _PaymentTerminalState extends State<PaymentTerminal> {
  bool _isScanning = false;
  bool _isAuthenticated = false;
  bool _isProcessing = false;

  void _startPayment() {
    setState(() => _isScanning = true);
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isScanning = false;
        _isAuthenticated = true;
      });
      Future.delayed(const Duration(seconds: 1), () {
        setState(() => _isProcessing = true);
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.of(context).pop();
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.5,
      maxChildSize: 0.75,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            color: AppTheme.darkSurfaceColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 12),
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  borderRadius: BorderRadius.circular(2),
                ),
              ).animate().fadeIn(duration: 300.ms),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (!_isAuthenticated && !_isProcessing) ...[
                      Icon(
                        Icons.contactless,
                        size: 100,
                        color: AppTheme.primaryColor,
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .scaleXY(
                            duration: const Duration(milliseconds: 800),
                            begin: 0.9,
                            end: 1.1,
                            curve: Curves.easeInOut,
                          ),
                      const SizedBox(height: 24),
                      Text(
                        'Hold near reader',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(delay: 200.ms, duration: 400.ms),
                      const SizedBox(height: 8),
                      Text(
                        'Place your phone near the payment terminal',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[400],
                        ),
                        textAlign: TextAlign.center,
                      ).animate().fadeIn(delay: 300.ms, duration: 400.ms),
                    ],
                    if (_isAuthenticated && !_isProcessing) ...[
                      const Icon(
                        Icons.face_retouching_natural,
                        size: 100,
                        color: Colors.green,
                      ).animate().scale(
                            duration: 400.ms,
                            curve: Curves.easeOutBack,
                          ),
                      const SizedBox(height: 24),
                      const Text(
                        'Authenticate to Pay',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 400.ms),
                    ],
                    if (_isProcessing) ...[
                      CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                        strokeWidth: 5,
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Processing Payment...',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ).animate().fadeIn(duration: 400.ms),
                    ],
                  ],
                ),
              ),
              if (!_isScanning && !_isAuthenticated)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: _startPayment,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Simulate Payment',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 400.ms).slideY(begin: 20, end: 0, duration: 500.ms),
                ),
            ],
          ),
        );
      },
    );
  }
}
