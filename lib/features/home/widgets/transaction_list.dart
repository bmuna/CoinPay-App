import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_theme.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Recent Transactions',
          style: Theme.of(context).textTheme.titleLarge,
        ).animate(delay: 1000.ms).fadeIn().slideX(begin: -30, end: 0),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return Card(
              margin: const EdgeInsets.only(bottom: 10),
              color: AppTheme.darkCardColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? Colors.green.withOpacity(0.15) : Colors.red.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    index % 2 == 0 ? Icons.call_received : Icons.call_made,
                    color: index % 2 == 0 ? Colors.green : Colors.red,
                    size: 20,
                  ),
                ),
                title: Text(
                  index % 2 == 0 ? 'Received BTC' : 'Sent BTC',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  '2023-12-${10 + index}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 12,
                  ),
                ),
                trailing: Text(
                  index % 2 == 0 ? '+0.0045 BTC' : '-0.0023 BTC',
                  style: TextStyle(
                    color: index % 2 == 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ),
            )
                .animate(delay: Duration(milliseconds: 600 + (index * 80)))
                .fadeIn(duration: 400.ms)
                .slideX(begin: 30, end: 0, duration: 500.ms, curve: Curves.easeOutQuint);
          },
        ),
      ],
    );
  }
}
