import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/widgets/app_card.dart';
import 'package:laundry_app/core/widgets/app_button.dart';
import 'package:laundry_app/core/widgets/input_field.dart';
import 'package:laundry_app/features/orders/presentation/screens/order_categories_screen.dart';
import 'package:laundry_app/features/orders/presentation/screens/payment_method_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final LaundryCategory category;

  const CheckoutScreen({
    super.key,
    required this.category,
  });

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  int _weight = 1;
  double _totalPrice = 0;
  String _selectedAddress = 'Home';
  DateTime? _pickupDate;
  DateTime? _deliveryDate;
  String _notes = '';
  String _voucherCode = '';
  bool _voucherApplied = false;

  final List<Address> _addresses = [
    Address(
      id: '1',
      name: 'Home',
      address: '123 Main St, Apt 4B',
      city: 'New York, NY 10001',
      isDefault: true,
    ),
    Address(
      id: '2',
      name: 'Office',
      address: '456 Work Ave, Floor 12',
      city: 'New York, NY 10002',
      isDefault: false,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _calculateTotal();
  }

  void _calculateTotal() {
    setState(() {
      _totalPrice = widget.category.price * _weight;
      if (_voucherApplied) {
        _totalPrice *= 0.9; // 10% discount
      }
    });
  }

  void _applyVoucher() {
    if (_voucherCode == 'LAUNDRY10') {
      setState(() {
        _voucherApplied = true;
      });
      _calculateTotal();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Voucher applied successfully!'),
          backgroundColor: AppColors.lightSuccess,
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Invalid voucher code'),
          backgroundColor: AppColors.lightError,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Checkout'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          gradient: LinearGradient(
                            colors: [
                              widget.category.color,
                              widget.category.color.withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        child: Icon(
                          widget.category.icon,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.category.name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            Text(
                              widget.category.description,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Divider(),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Weight',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: _weight > 1
                                ? () {
                                    setState(() {
                                      _weight--;
                                      _calculateTotal();
                                    });
                                  }
                                : null,
                            icon: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _weight > 1
                                    ? AppColors.lightPrimary
                                    : Colors.grey[300],
                              ),
                              child: const Icon(
                                Icons.remove,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                          Text(
                            '$_weight kg',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                            textAlign: TextAlign.center,
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _weight++;
                                _calculateTotal();
                              });
                            },
                            icon: Container(
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.lightPrimary,
                              ),
                              child: const Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Price per kg: \$${widget.category.price}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Address Selection
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Delivery Address',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  ..._addresses.map((address) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedAddress = address.id;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: _selectedAddress == address.id
                                ? AppColors.lightPrimary.withOpacity(0.1)
                                : Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withOpacity(0.5),
                            border: Border.all(
                              color: _selectedAddress == address.id
                                  ? AppColors.lightPrimary
                                  : Colors.transparent,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                address.isDefault
                                    ? Icons.home
                                    : Icons.business,
                                color: _selectedAddress == address.id
                                    ? AppColors.lightPrimary
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.7),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      address.name,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    Text(
                                      '${address.address}, ${address.city}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              if (_selectedAddress == address.id)
                                Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.lightPrimary,
                                  ),
                                  child: const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 12,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      // Add new address
                    },
                    icon: const Icon(Icons.add),
                    label: const Text('Add New Address'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Time Selection
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Schedule Pickup',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime.now().add(const Duration(days: 30)),
                            );
                            if (date != null) {
                              setState(() {
                                _pickupDate = date;
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.calendar_today, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  _pickupDate != null
                                      ? '${_pickupDate!.day}/${_pickupDate!.month}/${_pickupDate!.year}'
                                      : 'Select date',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: GestureDetector(
                          onTap: () async {
                            final time = await showTimePicker(
                              context: context,
                              initialTime: TimeOfDay.now(),
                            );
                            if (time != null && _pickupDate != null) {
                              setState(() {
                                _pickupDate = DateTime(
                                  _pickupDate!.year,
                                  _pickupDate!.month,
                                  _pickupDate!.day,
                                  time.hour,
                                  time.minute,
                                );
                              });
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Theme.of(context).dividerColor,
                              ),
                            ),
                            child: Row(
                              children: [
                                const Icon(Icons.access_time, size: 16),
                                const SizedBox(width: 8),
                                Text(
                                  _pickupDate != null
                                      ? '${_pickupDate!.hour}:${_pickupDate!.minute.toString().padLeft(2, '0')}'
                                      : 'Select time',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Notes
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Special Instructions',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: 'Any special instructions for your order...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onChanged: (value) {
                      setState(() {
                        _notes = value;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Voucher Code
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Voucher Code',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Enter voucher code',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          onChanged: (value) {
                            setState(() {
                              _voucherCode = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      AppButton.secondary(
                        onPressed: _applyVoucher,
                        label: 'Apply',
                        fullWidth: false,
                      ),
                    ],
                  ),
                  if (_voucherApplied)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        '10% discount applied!',
                        style: TextStyle(
                          color: AppColors.lightSuccess,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Payment Breakdown
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Payment Summary',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 12),
                  _buildPaymentRow('Service Cost', '\$${widget.category.price * _weight}'),
                  _buildPaymentRow('Delivery Fee', '\$2.99'),
                  if (_voucherApplied)
                    _buildPaymentRow('Discount (10%)', '-\$${(widget.category.price * _weight * 0.1).toStringAsFixed(2)}'),
                  const Divider(),
                  _buildPaymentRow('Total', '\$${(_totalPrice + 2.99).toStringAsFixed(2)}', isTotal: true),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Secure Payment Text
            Center(
              child: Text(
                '🔒 Secure payment · 256-bit SSL encrypted',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.lightTextSecondary,
                    ),
              ),
            ),
            const SizedBox(height: 16),
            // Proceed Button
            AppButton.primary(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PaymentMethodScreen(),
                  ),
                );
              },
              label: 'Proceed to Payment',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isTotal ? null : AppColors.lightTextSecondary,
                  fontWeight: isTotal ? FontWeight.w600 : null,
                ),
          ),
          Text(
            value,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: isTotal ? FontWeight.w700 : FontWeight.w600,
                  color: isTotal ? AppColors.lightPrimary : null,
                ),
          ),
        ],
      ),
    );
  }
}

class Address {
  final String id;
  final String name;
  final String address;
  final String city;
  final bool isDefault;

  Address({
    required this.id,
    required this.name,
    required this.address,
    required this.city,
    required this.isDefault,
  });
}