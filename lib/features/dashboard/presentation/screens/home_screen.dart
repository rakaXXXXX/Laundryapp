import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/providers/auth_provider.dart';
import 'package:laundry_app/features/dashboard/presentation/widgets/category_list.dart';
import 'package:laundry_app/features/dashboard/presentation/widgets/promo_carousel.dart';
import 'package:laundry_app/features/dashboard/presentation/widgets/services_grid.dart';
import 'package:laundry_app/features/navigation/bottom_nav_bar.dart';
import 'package:laundry_app/routes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _screens = const [
    HomeContent(),
    Center(child: Text('Orders Tab - Coming Soon')),
    Center(child: Text('Chat Tab - Coming Soon')),
    Center(child: Text('Profile Tab - Coming Soon')),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.orderCategories);
              },
              backgroundColor: AppColors.lightPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 120,
          floating: true,
          pinned: true,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
              ),
            ),
          ),
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  user?.name.substring(0, 1).toUpperCase() ?? 'U',
                  style: const TextStyle(
                    color: AppColors.lightPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Good ${_getGreeting()}!',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Colors.white70,
                        ),
                  ),
                  Text(
                    user?.name ?? 'Guest',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search, color: Colors.white),
            ),
            IconButton(
              onPressed: () {},
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.white),
            ),
          ],
        ),
        SliverPadding(
          padding: const EdgeInsets.all(16),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const PromoCarousel(),
              const SizedBox(height: 24),
              Text(
                'Categories',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 12),
              const CategoryList(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Services',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text('View All'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const ServiceGrid(),
            ]),
          ),
        ),
      ],
    );
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Morning';
    if (hour < 18) return 'Afternoon';
    return 'Evening';
  }
}
