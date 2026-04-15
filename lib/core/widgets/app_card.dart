import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final VoidCallback? onTap;
  final double borderRadius;
  final Color? backgroundColor;
  final bool showGlassEffect;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = EdgeInsets.zero,
    this.onTap,
    this.borderRadius = 20,
    this.backgroundColor,
    this.showGlassEffect = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: backgroundColor ??
            (isDarkMode ? AppColors.darkSurface : AppColors.lightSurface),
        gradient: showGlassEffect
            ? isDarkMode
                ? AppColors.darkGlassGradient
                : AppColors.glassGradient
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 4),
          ),
        ],
        border: showGlassEffect
            ? Border.all(
                color: Colors.white.withOpacity(0.1),
                width: 1,
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Padding(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}