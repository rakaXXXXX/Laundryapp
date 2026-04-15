import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/widgets/app_card.dart';
import 'package:laundry_app/core/widgets/app_button.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'ewallet';

  final List<PaymentMethod> _methods = [
    PaymentMethod(
      id: 'ewallet',
      name: 'E-Wallet',
      description: 'Gopay, OVO, DANA',
      icon: Icons.wallet,
      color: AppColors.lightPrimary,
    ),
    PaymentMethod(
      id: 'bank',
      name: 'Bank Transfer',
      description: 'BCA, Mandiri, BNI',
      icon: Icons.account_balance,
      color: Colors.blue,
    ),
    PaymentMethod(
      id: 'qris',
      name: 'QRIS',
      description: 'Scan QR Code',
      icon: Icons.qr_code,
      color: Colors.green,
    ),
    PaymentMethod(
      id: 'cod',
      name: 'Cash on Delivery',
      description: 'Pay when order arrives',
      icon: Icons.money,
      color: Colors.orange,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final totalAmount = 28.97; // Example total

    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Method'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Payment Method',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Choose your preferred payment method',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppColors.lightTextSecondary,
                        ),
                  ),
                  const SizedBox(height: 24),
                  ..._methods.map((method) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedMethod = method.id;
                          });
                        },
                        child: AppCard(
                          child: Row(
                            children: [
                              Container(
                                width: 48,
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  color: method.color.withOpacity(0.1),
                                ),
                                child: Icon(
                                  method.icon,
                                  color: method.color,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      method.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      method.description,
                                      style: Theme.of(context).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                              ),
                              Radio(
                                value: method.id,
                                groupValue: _selectedMethod,
                                onChanged: (value) {
                                  setState(() {
                                    _selectedMethod = value!;
                                  });
                                },
                                activeColor: method.color,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 24),
                  // Payment Details
                  AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Order Summary',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildSummaryRow('Service Cost', '\$25.98'),
                        _buildSummaryRow('Delivery Fee', '\$2.99'),
                        _buildSummaryRow('Total Amount', '\$$totalAmount'),
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        Text(
                          'Payment will be processed securely',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: AppColors.lightSuccess,
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom Action
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: Theme.of(context).dividerColor,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Total to Pay',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: AppColors.lightTextSecondary,
                            ),
                      ),
                      Text(
                        '\$$totalAmount',
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.lightPrimary,
                            ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 160,
                  child: AppButton.primary(
                    onPressed: () {
                      // Process payment
                      _processPayment();
                    },
                    label: 'Confirm Payment',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    );
  }

  void _processPayment() async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      Navigator.pop(context); // Close loading
      
      // Show success dialog
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Payment Successful!'),
          content: const Text('Your order has been placed successfully. You can track your order in the orders section.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: const Text('Back to Home'),
            ),
          ],
        ),
      );
    }
  }
}

class PaymentMethod {
  final String id;
  final String name;
  final String description;
  final IconData icon;
  final Color color;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    required this.color,
  });
}