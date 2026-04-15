import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry_app/core/providers/order_provider.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/features/orders/domain/models/laundry_category.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({super.key});

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _selectedIndex = 0;

  IconData _getIconForCategory(LaundryCategory category) {
    // Map category name to appropriate icon
    switch (category.name.toLowerCase()) {
      case 'all':
        return Icons.all_inclusive;
      case 'wash':
      case 'wash & fold':
      case 'regular wash':
        return Icons.local_laundry_service;
      case 'dry clean':
      case 'dry cleaning':
        return Icons.clean_hands;
      case 'ironing':
        return Icons.iron;
      case 'express':
        return Icons.flash_on;
      default:
        return Icons.local_laundry_service;
    }
  }

  Color _getColorForCategory(LaundryCategory category) {
    // Map category to colors
    switch (category.name.toLowerCase()) {
      case 'all':
        return AppColors.lightPrimary;
      case 'wash':
      case 'wash & fold':
        return AppColors.lightPrimary;
      case 'dry clean':
        return Colors.purple;
      case 'ironing':
        return Colors.orange;
      case 'express':
        return Colors.red;
      default:
        return AppColors.lightPrimary;
    }
  }

  @override
  Widget build(BuildContext context) {
    final categories = context.watch<OrderProvider>().categories;

    if (categories.isEmpty) {
      return SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = index == _selectedIndex;
          final categoryColor = _getColorForCategory(category);
          final iconData = _getIconForCategory(category);

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              // TODO: Implement category filter logic
            },
            child: Container(
              width: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: isSelected
                          ? categoryColor
                          : Theme.of(context).colorScheme.surface,
                      gradient: isSelected
                          ? LinearGradient(
                              colors: [
                                categoryColor,
                                categoryColor.withOpacity(0.8),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                          : null,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: categoryColor.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ]
                          : [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 10,
                                spreadRadius: 1,
                              ),
                            ],
                    ),
                    child: Icon(
                      iconData,
                      color: isSelected ? Colors.white : categoryColor,
                      size: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: Text(
                      category.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: isSelected
                                ? categoryColor
                                : Theme.of(context).colorScheme.onSurface,
                          ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
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
