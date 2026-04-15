import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onPressed;
  final Color? color;

  const SocialLoginButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          color: isDarkMode
              ? AppColors.darkTextSecondary.withOpacity(0.3)
              : AppColors.lightTextSecondary.withOpacity(0.3),
        ),
        backgroundColor: isDarkMode
            ? AppColors.darkSurface.withOpacity(0.5)
            : Colors.white.withOpacity(0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color ??
                (isDarkMode ? AppColors.darkText : AppColors.lightText),
            size: 24,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDarkMode ? AppColors.darkText : AppColors.lightText,
            ),
          ),
        ],
      ),
    );
  }
}