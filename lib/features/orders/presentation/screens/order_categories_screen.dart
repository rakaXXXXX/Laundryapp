import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/widgets/app_card.dart';
import 'package:laundry_app/core/widgets/app_button.dart';
import 'package:laundry_app/features/orders/presentation/screens/checkout_screen.dart';

class OrderCategoriesScreen extends StatefulWidget {
  const OrderCategoriesScreen({super.key});

  @override
  State<OrderCategoriesScreen> createState() => _OrderCategoriesScreenState();
}

class _OrderCategoriesScreenState extends State<OrderCategoriesScreen> {
  String _selectedCategory = '';
  String _searchQuery = '';

  final List<LaundryCategory> _categories = [
    LaundryCategory(
      id: '1',
      name: 'Regular Wash',
      description: 'Standard wash & fold service',
      price: 5.99,
      icon: Icons.local_laundry_service,
      color: AppColors.lightPrimary,
    ),
    LaundryCategory(
      id: '2',
      name: 'Dry Cleaning',
      description: 'Professional dry cleaning for delicate fabrics',
      price: 12.99,
      icon: Icons.clean_hands,
      color: Colors.purple,
    ),
    LaundryCategory(
      id: '3',
      name: 'Ironing',
      description: 'Premium ironing service',
      price: 3.99,
      icon: Icons.iron,
      color: Colors.orange,
    ),
    LaundryCategory(
      id: '4',
      name: 'Express Service',
      description: 'Fast 3-hour delivery service',
      price: 9.99,
      icon: Icons.flash_on,
      color: Colors.red,
    ),
    LaundryCategory(
      id: '5',
      name: 'Blanket & Bedding',
      description: 'Heavy items washing service',
      price: 15.99,
      icon: Icons.bed,
      color: Colors.green,
    ),
    LaundryCategory(
      id: '6',
      name: 'Shoe Cleaning',
      description: 'Professional shoe care',
      price: 8.99,
      icon: Icons.directions_walk,
      color: Colors.brown,
    ),
    LaundryCategory(
      id: '7',
      name: 'Leather Care',
      description: 'Specialized leather cleaning',
      price: 19.99,
      icon: Icons.style,
      color: Colors.amber,
    ),
    LaundryCategory(
      id: '8',
      name: 'Curtain Cleaning',
      description: 'Professional curtain cleaning',
      price: 25.99,
      icon: Icons.curtains,
      color: Colors.blue,
    ),
  ];

  List<LaundryCategory> get _filteredCategories {
    if (_searchQuery.isEmpty) return _categories;
    return _categories.where((category) {
      return category.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          category.description.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Service'),
        actions: [
          IconButton(
            onPressed: () {
              _showFilterModal();
            },
            icon: const Icon(Icons.filter_list),
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Theme.of(context).dividerColor.withOpacity(0.1),
                ),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search services...',
                  border: InputBorder.none,
                  icon: const Icon(Icons.search),
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _searchQuery = '';
                            });
                          },
                          icon: const Icon(Icons.clear),
                        )
                      : null,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
          ),
          // Categories Grid
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.85,
                ),
                itemCount: _filteredCategories.length,
                itemBuilder: (context, index) {
                  final category = _filteredCategories[index];
                  final isSelected = _selectedCategory == category.id;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCategory = category.id;
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: isSelected
                            ? category.color.withOpacity(0.1)
                            : Theme.of(context).colorScheme.surface,
                        border: Border.all(
                          color: isSelected
                              ? category.color
                              : Colors.transparent,
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                gradient: LinearGradient(
                                  colors: [
                                    category.color,
                                    category.color.withOpacity(0.8),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Icon(
                                category.icon,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              category.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              category.description,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'From \$${category.price}',
                                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                        fontWeight: FontWeight.w700,
                                        color: category.color,
                                      ),
                                ),
                                if (isSelected)
                                  Container(
                                    width: 24,
                                    height: 24,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: category.color,
                                    ),
                                    child: const Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          // Continue Button
          if (_selectedCategory.isNotEmpty)
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppButton.primary(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CheckoutScreen(
                        category: _categories.firstWhere(
                          (cat) => cat.id == _selectedCategory,
                        ),
                      ),
                    ),
                  );
                },
                label: 'Continue',
              ),
            ),
        ],
      ),
    );
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Services',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 20),
              // Add filter options here
              AppButton.primary(
                onPressed: () {
                  Navigator.pop(context);
                },
                label: 'Apply Filters',
              ),
            ],
          ),
        );
      },
    );
  }
}

class LaundryCategory {
  final String id;
  final String name;
  final String description;
  final double price;
  final IconData icon;
  final Color color;

  LaundryCategory({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.icon,
    required this.color,
  });
}