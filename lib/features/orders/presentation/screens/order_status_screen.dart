import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/widgets/app_button.dart';
import 'package:laundry_app/core/widgets/app_card.dart';

class OrderStatusScreen extends StatelessWidget {
  final String orderId;
  final OrderStatus status;

  const OrderStatusScreen({
    super.key,
    required this.orderId,
    this.status = OrderStatus.processing,
  });

  @override
  Widget build(BuildContext context) {
    final steps = OrderStatus.values;
    final currentStepIndex = steps.indexOf(status);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Status'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order ID Card
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Order #$orderId',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Estimated completion: Today, 5:00 PM',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Timeline
            Text(
              'Order Progress',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: AppColors.glassGradient,
              ),
              child: Column(
                children: [
                  for (var i = 0; i < steps.length; i++) ...[
                    TimelineStep(
                      step: steps[i],
                      isActive: i == currentStepIndex,
                      isCompleted: i < currentStepIndex,
                      isLast: i == steps.length - 1,
                    ),
                    if (i < steps.length - 1) const SizedBox(height: 20),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: AppButton.secondary(
                    onPressed: () {
                      // Chat
                    },
                    label: 'Contact Support',
                    icon: Icons.chat_outlined,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: AppButton.primary(
                    onPressed: () {
                      // Download invoice
                    },
                    label: 'Download Invoice',
                    icon: Icons.download_outlined,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TimelineStep extends StatelessWidget {
  final OrderStatus step;
  final bool isActive;
  final bool isCompleted;
  final bool isLast;

  const TimelineStep({
    super.key,
    required this.step,
    required this.isActive,
    required this.isCompleted,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isCompleted
                    ? AppColors.lightSuccess
                    : isActive
                        ? AppColors.lightPrimary
                        : isDarkMode
                            ? AppColors.darkSurface
                            : AppColors.lightSurface,
                border: Border.all(
                  color: isActive
                      ? AppColors.lightPrimary
                      : Colors.transparent,
                  width: 2,
                ),
                boxShadow: isActive
                    ? [
                        BoxShadow(
                          color: AppColors.lightPrimary.withOpacity(0.5),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Icon(
                  _getStepIcon(step),
                  color: isCompleted || isActive
                      ? Colors.white
                      : isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                  size: 20,
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 40,
                margin: const EdgeInsets.only(top: 4),
                color: isCompleted
                    ? AppColors.lightSuccess
                    : isDarkMode
                        ? AppColors.darkTextSecondary.withOpacity(0.3)
                        : AppColors.lightTextSecondary.withOpacity(0.3),
              ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getStepTitle(step),
                style: theme.textTheme.titleLarge?.copyWith(
                  color: isCompleted || isActive
                      ? AppColors.lightPrimary
                      : null,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getStepDescription(step),
                style: theme.textTheme.bodyMedium,
              ),
              if (isActive) ...[
                const SizedBox(height: 8),
                Container(
                  width: double.infinity,
                  height: 4,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    gradient: AppColors.primaryGradient,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  IconData _getStepIcon(OrderStatus step) {
    switch (step) {
      case OrderStatus.pending:
        return Icons.schedule_outlined;
      case OrderStatus.confirmed:
        return Icons.check_circle_outline;
      case OrderStatus.processing:
        return Icons.local_laundry_service_outlined;
      case OrderStatus.ready:
        return Icons.check_circle_outline;
      case OrderStatus.delivered:
        return Icons.local_shipping_outlined;
      case OrderStatus.completed:
        return Icons.done_all_outlined;
    }
  }

  String _getStepTitle(OrderStatus step) {
    switch (step) {
      case OrderStatus.pending:
        return 'Order Placed';
      case OrderStatus.confirmed:
        return 'Order Confirmed';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.ready:
        return 'Ready for Pickup';
      case OrderStatus.delivered:
        return 'On the Way';
      case OrderStatus.completed:
        return 'Completed';
    }
  }

  String _getStepDescription(OrderStatus step) {
    switch (step) {
      case OrderStatus.pending:
        return 'Your order has been received';
      case OrderStatus.confirmed:
        return 'We\'ve accepted your order';
      case OrderStatus.processing:
        return 'Your clothes are being cleaned';
      case OrderStatus.ready:
        return 'Your order is ready for pickup';
      case OrderStatus.delivered:
        return 'Your order is on the way';
      case OrderStatus.completed:
        return 'Order delivered successfully';
    }
  }
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  ready,
  delivered,
  completed,
}