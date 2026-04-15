import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/widgets/app_card.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orders = [
      OrderHistory(
        id: 'LAU-2024-00123',
        date: 'Today, 3:30 PM',
        service: 'Regular Wash',
        status: 'Processing',
        amount: 28.97,
        statusColor: Colors.orange,
      ),
      OrderHistory(
        id: 'LAU-2024-00122',
        date: 'Yesterday, 2:15 PM',
        service: 'Dry Cleaning',
        status: 'Completed',
        amount: 45.97,
        statusColor: Colors.green,
      ),
      OrderHistory(
        id: 'LAU-2024-00121',
        date: 'Jan 15, 2024',
        service: 'Ironing Service',
        status: 'Completed',
        amount: 15.97,
        statusColor: Colors.green,
      ),
      OrderHistory(
        id: 'LAU-2024-00120',
        date: 'Jan 10, 2024',
        service: 'Express Service',
        status: 'Cancelled',
        amount: 9.99,
        statusColor: Colors.red,
      ),
      OrderHistory(
        id: 'LAU-2024-00119',
        date: 'Jan 5, 2024',
        service: 'Blanket Wash',
        status: 'Completed',
        amount: 25.99,
        statusColor: Colors.green,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order History'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: AppCard(
              onTap: () {
                // Navigate to order details
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Order #${order.id}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: order.statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          order.status,
                          style: TextStyle(
                            color: order.statusColor,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    order.date,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    order.service,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        '\$${order.amount}',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightPrimary,
                            ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderHistory {
  final String id;
  final String date;
  final String service;
  final String status;
  final double amount;
  final Color statusColor;

  OrderHistory({
    required this.id,
    required this.date,
    required this.service,
    required this.status,
    required this.amount,
    required this.statusColor,
  });
}
