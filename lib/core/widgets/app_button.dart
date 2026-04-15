import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';

enum ButtonType { primary, secondary, ghost }

class AppButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final ButtonType type;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.icon,
    this.fullWidth = true,
  });

  factory AppButton.primary({
    required VoidCallback onPressed,
    required String label,
    bool isLoading = false,
    IconData? icon,
    bool fullWidth = true,
  }) {
    return AppButton(
      onPressed: onPressed,
      label: label,
      type: ButtonType.primary,
      isLoading: isLoading,
      icon: icon,
      fullWidth: fullWidth,
    );
  }

  factory AppButton.secondary({
    required VoidCallback onPressed,
    required String label,
    bool isLoading = false,
    IconData? icon,
    bool fullWidth = true,
  }) {
    return AppButton(
      onPressed: onPressed,
      label: label,
      type: ButtonType.secondary,
      isLoading: isLoading,
      icon: icon,
      fullWidth: fullWidth,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    Color backgroundColor;
    Color textColor;
    Color borderColor;

    switch (type) {
      case ButtonType.primary:
        backgroundColor = AppColors.lightPrimary;
        textColor = Colors.white;
        borderColor = AppColors.lightPrimary;
        break;
      case ButtonType.secondary:
        backgroundColor = isDarkMode
            ? AppColors.darkSurface
            : AppColors.lightSurface;
        textColor = isDarkMode
            ? AppColors.darkText
            : AppColors.lightText;
        borderColor = isDarkMode
            ? AppColors.darkTextSecondary.withOpacity(0.3)
            : AppColors.lightTextSecondary.withOpacity(0.3);
        break;
      case ButtonType.ghost:
        backgroundColor = Colors.transparent;
        textColor = isDarkMode
            ? AppColors.darkText
            : AppColors.lightText;
        borderColor = Colors.transparent;
        break;
    }

    return SizedBox(
      width: fullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          foregroundColor: textColor,
          disabledBackgroundColor: backgroundColor.withOpacity(0.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: borderColor,
              width: 1,
            ),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 16,
          ),
        ),
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}