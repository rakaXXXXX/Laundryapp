import 'package:flutter/material.dart';
import 'package:laundry_app/features/auth/presentation/screens/login_screen.dart';
import 'package:laundry_app/features/auth/presentation/screens/register_screen.dart';
import 'package:laundry_app/features/dashboard/presentation/screens/home_screen.dart';
import 'package:laundry_app/features/orders/presentation/screens/order_categories_screen.dart';
import 'package:laundry_app/features/orders/presentation/screens/checkout_screen.dart';
import 'package:laundry_app/features/orders/presentation/screens/order_status_screen.dart';
import 'package:laundry_app/features/orders/presentation/screens/payment_method_screen.dart';
import 'package:laundry_app/features/chat/presentation/screens/chat_screen.dart';
import 'package:laundry_app/features/profile/presentation/screens/profile_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String orderCategories = '/order-categories';
  static const String checkout = '/checkout';
  static const String orderStatus = '/order-status';
  static const String paymentMethod = '/payment-method';
  static const String chat = '/chat';
  static const String profile = '/profile';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case orderCategories:
        return MaterialPageRoute(builder: (_) => const OrderCategoriesScreen());
      case checkout:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => CheckoutScreen(
            category: args['category'],
          ),
        );
      case orderStatus:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => OrderStatusScreen(
            orderId: args['orderId'],
            status: args['status'],
          ),
        );
      case paymentMethod:
        return MaterialPageRoute(builder: (_) => const PaymentMethodScreen());
      case chat:
        return MaterialPageRoute(builder: (_) => const ChatScreen());
      case profile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}