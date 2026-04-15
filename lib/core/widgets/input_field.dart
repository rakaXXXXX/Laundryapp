import 'package:flutter/material.dart';
import 'package:laundry_app/core/constants/app_colors.dart';

class InputField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final bool autofocus;

  const InputField({
    super.key,
    required this.controller,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.validator,
    this.onChanged,
    this.autofocus = false,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: theme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Focus(
          onFocusChange: (focused) {
            setState(() {
              _isFocused = focused;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: _isFocused
                  ? LinearGradient(
                      colors: [
                        AppColors.lightPrimary.withOpacity(0.2),
                        AppColors.lightSecondary.withOpacity(0.2),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : null,
              border: _isFocused
                  ? Border.all(
                      color: AppColors.lightPrimary,
                      width: 2,
                    )
                  : null,
              boxShadow: _isFocused
                  ? [
                      BoxShadow(
                        color: AppColors.lightPrimary.withOpacity(0.3),
                        blurRadius: 10,
                        spreadRadius: 1,
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
            child: TextFormField(
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              obscureText: widget.obscureText,
              autofocus: widget.autofocus,
              onChanged: widget.onChanged,
              validator: widget.validator,
              style: theme.textTheme.bodyLarge,
              decoration: InputDecoration(
                hintText: widget.hintText,
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: isDarkMode
                      ? AppColors.darkTextSecondary
                      : AppColors.lightTextSecondary,
                ),
                prefixIcon: Icon(
                  widget.prefixIcon,
                  color: _isFocused
                      ? AppColors.lightPrimary
                      : isDarkMode
                          ? AppColors.darkTextSecondary
                          : AppColors.lightTextSecondary,
                ),
                suffixIcon: widget.suffixIcon,
                filled: true,
                fillColor: isDarkMode
                    ? AppColors.darkSurface.withOpacity(0.8)
                    : Colors.white.withOpacity(0.9),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}