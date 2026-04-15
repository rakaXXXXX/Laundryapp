import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges; // Import dengan alias 'badges'
import 'package:laundry_app/core/constants/app_colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? AppColors.darkSurface : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDarkMode
                ? AppColors.darkTextSecondary.withOpacity(0.1)
                : AppColors.lightTextSecondary.withOpacity(0.1),
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavItem(
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                isActive: currentIndex == 0,
                onTap: () => onTap(0),
              ),
              badges.Badge(
                // Gunakan badges.Badge bukan badge.Badge
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: Colors.red,
                ),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                position: badges.BadgePosition.topEnd(top: -8, end: -8),
                child: _NavItem(
                  icon: Icons.shopping_bag_outlined,
                  activeIcon: Icons.shopping_bag,
                  label: 'Orders',
                  isActive: currentIndex == 1,
                  onTap: () => onTap(1),
                ),
              ),
              badges.Badge(
                // Gunakan badges.Badge
                badgeStyle: const badges.BadgeStyle(
                  badgeColor: AppColors.lightPrimary,
                ),
                badgeContent: const Text(
                  '1',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                position: badges.BadgePosition.topEnd(top: -8, end: -8),
                child: _NavItem(
                  icon: Icons.chat_bubble_outline,
                  activeIcon: Icons.chat_bubble,
                  label: 'Chat',
                  isActive: currentIndex == 2,
                  onTap: () => onTap(2),
                ),
              ),
              _NavItem(
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                label: 'Profile',
                isActive: currentIndex == 3,
                onTap: () => onTap(3),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isActive
              ? AppColors.lightPrimary.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive
                  ? AppColors.lightPrimary
                  : isDarkMode
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: isActive
                    ? AppColors.lightPrimary
                    : isDarkMode
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
