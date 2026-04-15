import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';

class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: AppColors.primaryGradient,
          ),
          child: const Icon(
            Icons.local_laundry_service,
            color: Colors.white,
            size: 32,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          'Laundry Pro',
          style: Theme.of(
            context,
          ).textTheme.displaySmall?.copyWith(fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 4),
        Text(
          'Premium laundry service at your doorstep',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
