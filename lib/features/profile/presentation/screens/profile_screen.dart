import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/widgets/app_card.dart';
import 'package:laundry_app/core/widgets/app_button.dart';
import 'package:laundry_app/core/providers/auth_provider.dart';
import 'package:laundry_app/features/profile/presentation/widgets/profile_menu_item.dart';
import 'package:laundry_app/features/profile/presentation/widgets/order_history.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().user;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: Colors.transparent,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Profile Header
                Transform.translate(
                  offset: const Offset(0, -60),
                  child: AppCard(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor:
                              AppColors.lightPrimary.withOpacity(0.1),
                          child: Icon(
                            Icons.person,
                            size: 60,
                            color: AppColors.lightPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user?.name ?? 'Guest User',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user?.email ?? 'guest@example.com',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildStatItem('Orders', '12'),
                            const SizedBox(width: 32),
                            _buildStatItem('Points', '1,250'),
                            const SizedBox(width: 32),
                            _buildStatItem('Rating', '4.8'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Menu Items
                AppCard(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    children: [
                      ProfileMenuItem(
                        icon: Icons.settings,
                        title: 'Settings',
                        onTap: () {
                          // Navigate to settings
                        },
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.notifications,
                        title: 'Notifications',
                        trailing: Switch(
                          value: _notificationsEnabled,
                          onChanged: (value) {
                            setState(() {
                              _notificationsEnabled = value;
                            });
                          },
                        ),
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.payment,
                        title: 'Payment Methods',
                        onTap: () {
                          // Navigate to payment methods
                        },
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.history,
                        title: 'Order History',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const OrderHistoryScreen(),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.help,
                        title: 'Help Center',
                        onTap: () {
                          // Navigate to help center
                        },
                      ),
                      const Divider(height: 1),
                      ProfileMenuItem(
                        icon: Icons.info,
                        title: 'About Us',
                        onTap: () {
                          // Navigate to about us
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                // Logout Button
                AppButton.secondary(
                  onPressed: () {
                    _showLogoutDialog();
                  },
                  label: 'Logout',
                  icon: Icons.logout,
                ),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.lightPrimary,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<AuthProvider>().logout();
            },
            child: const Text(
              'Logout',
              style: TextStyle(color: AppColors.lightError),
            ),
          ),
        ],
      ),
    );
  }
}
