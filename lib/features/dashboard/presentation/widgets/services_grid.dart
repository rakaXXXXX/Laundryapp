import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/widgets/app_button.dart';

class ServiceGrid extends StatelessWidget {
  const ServiceGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      Service(
        id: '1',
        name: 'Regular Wash',
        description: 'Wash & fold service',
        price: 5.99,
        icon: Icons.local_laundry_service,
        color: AppColors.lightPrimary,
      ),
      Service(
        id: '2',
        name: 'Dry Cleaning',
        description: 'Professional dry cleaning',
        price: 12.99,
        icon: Icons.clean_hands,
        color: Colors.purple,
      ),
      Service(
        id: '3',
        name: 'Ironing',
        description: 'Premium ironing service',
        price: 3.99,
        icon: Icons.iron,
        color: Colors.orange,
      ),
      Service(
        id: '4',
        name: 'Express Service',
        description: '3-hour delivery',
        price: 9.99,
        icon: Icons.flash_on,
        color: Colors.red,
      ),
      Service(
        id: '5',
        name: 'Blanket Wash',
        description: 'Heavy items washing',
        price: 15.99,
        icon: Icons.bed,
        color: Colors.green,
      ),
      Service(
        id: '6',
        name: 'Shoe Cleaning',
        description: 'Professional shoe care',
        price: 8.99,
        icon: Icons.directions_walk,
        color: Colors.brown,
      ),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.8,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return ServiceCard(service: service);
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final Service service;

  const ServiceCard({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              gradient: LinearGradient(
                colors: [
                  service.color,
                  service.color.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: Icon(
                service.icon,
                color: Colors.white,
                size: 40,
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  service.description,
                  style: Theme.of(context).textTheme.bodySmall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${service.price.toStringAsFixed(2)}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            color: service.color,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    SizedBox(
                      width: 80,
                      child: AppButton.secondary(
                        onPressed: () {
                          // Order now
                        },
                        label: 'Order',
                        fullWidth: false,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Service {
  final String id;
  final String name;
  final String description;
  final double price;
  final IconData icon;
  final Color color;

  Service({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.color,
  });
}