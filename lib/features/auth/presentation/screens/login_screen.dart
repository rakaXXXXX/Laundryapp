import 'package:flutter/material.dart';
import 'package:laundry_app/features/auth/presentation/screens/register_screen.dart';
import 'package:provider/provider.dart';
import 'package:laundry_app/core/widgets/input_field.dart';
import 'package:laundry_app/core/widgets/app_button.dart';
import 'package:laundry_app/core/constants/app_colors.dart';
import 'package:laundry_app/core/providers/theme_provider.dart';
import 'package:laundry_app/core/providers/auth_provider.dart';
import 'package:laundry_app/features/auth/presentation/widgets/auth_header.dart';
import 'package:laundry_app/features/auth/presentation/widgets/social_login_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      final authProvider = context.read<AuthProvider>();
      final success = await authProvider.login(
        _emailController.text,
        _passwordController.text,
      );

      if (success && mounted) {
        // Navigate to home - implement navigation logic here
        // Example: Navigator.pushReplacementNamed(context, '/home');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Invalid credentials'),
            backgroundColor: AppColors.lightError,
          ),
        );
      }
    }
  }

  void _navigateToRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                // Header with Theme Toggle
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AuthHeader(),
                    IconButton(
                      onPressed: themeProvider.toggleTheme,
                      icon: Icon(
                        isDarkMode ? Icons.light_mode : Icons.dark_mode,
                        color: isDarkMode
                            ? AppColors.darkText
                            : AppColors.lightText,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Text(
                  'Welcome Back!',
                  style: Theme.of(context).textTheme.displaySmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Sign in to continue',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 32),
                // Email Field
                InputField(
                  controller: _emailController,
                  label: 'Email',
                  hintText: 'Enter your email',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Password Field
                InputField(
                  controller: _passwordController,
                  label: 'Password',
                  hintText: 'Enter your password',
                  prefixIcon: Icons.lock_outline,
                  obscureText: _obscurePassword,
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // Implement forgot password logic
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: AppColors.lightPrimary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Login Button
                AppButton.primary(
                  onPressed: _login,
                  label: 'Sign In',
                  isLoading: context.watch<AuthProvider>().isLoading,
                ),
                const SizedBox(height: 32),
                // Divider
                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        color: isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'or continue with',
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        color: isDarkMode
                            ? AppColors.darkTextSecondary
                            : AppColors.lightTextSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Social Login
                SocialLoginButton(
                  icon: Icons.g_mobiledata,
                  label: 'Continue with Google',
                  onPressed: () async {
                    await context.read<AuthProvider>().googleSignIn();
                  },
                ),
                const SizedBox(height: 24),
                // Register Link
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          color: isDarkMode
                              ? AppColors.darkTextSecondary
                              : AppColors.lightTextSecondary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _navigateToRegister(context),
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            color: AppColors.lightPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
