import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:laundry_app/features/orders/domain/models/order.dart';
import 'package:laundry_app/features/orders/domain/models/laundry_category.dart';
import 'package:laundry_app/core/services/api_services.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders(String userId);
  Future<Order> createOrder(Order order);
  Future<Order> updateOrder(Order order);
  Future<Order?> getOrder(String id);
  List<LaundryCategory> getCategories();
}

class OrderRepositoryImpl implements OrderRepository {
  final ApiService _apiService;
  static const String _ordersKey = 'orders';

  OrderRepositoryImpl({required ApiService apiService})
      : _apiService = apiService;

  @override
  Future<List<Order>> getOrders(String userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final ordersJson = prefs.getStringList(_ordersKey) ?? [];
      final orders = <Order>[];
      for (final jsonStr in ordersJson) {
        final orderMap = json.decode(jsonStr) as Map<String, dynamic>;
        orders.add(Order.fromJson(orderMap));
      }
      final filteredOrders =
          orders.where((order) => order.userId == userId).toList();
      return filteredOrders;
    } catch (e) {
      return [];
    }
  }

  @override
  Future<Order> createOrder(Order order) async {
    final newOrder = Order(
      id: const Uuid().v4(),
      userId: order.userId,
      category: order.category,
      weight: order.weight,
      totalPrice: order.totalPrice,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
    );

    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList(_ordersKey) ?? [];
    ordersJson.add(json.encode(newOrder.toJson()));
    await prefs.setStringList(_ordersKey, ordersJson);

    await _apiService.post('/orders', newOrder.toJson());

    return newOrder;
  }

  @override
  Future<Order> updateOrder(Order order) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList(_ordersKey) ?? [];
    final index = ordersJson
        .indexWhere((jsonStr) => json.decode(jsonStr)['id'] == order.id);
    if (index != -1) {
      ordersJson[index] = json.encode(order.toJson());
      await prefs.setStringList(_ordersKey, ordersJson);
    }

    await _apiService.put('/orders/${order.id}', order.toJson());

    return order;
  }

  @override
  Future<Order?> getOrder(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final ordersJson = prefs.getStringList(_ordersKey) ?? [];
    final orderStr = ordersJson.firstWhere(
      (jsonStr) => json.decode(jsonStr)['id'] == id,
      orElse: () => '',
    );
    if (orderStr.isNotEmpty) {
      final orderMap = json.decode(orderStr) as Map<String, dynamic>;
      final order = Order.fromJson(orderMap);
      return order;
    }
    return null;
  }

  @override
  List<LaundryCategory> getCategories() {
    return _getMockCategories();
  }

  List<LaundryCategory> _getMockCategories() {
    return [
      const LaundryCategory(
        id: '1',
        name: 'Regular Wash',
        icon: 'assets/icons/wash.svg',
        basePrice: 5.99,
        description: 'Standard machine wash and fold',
      ),
      const LaundryCategory(
        id: '2',
        name: 'Dry Cleaning',
        icon: 'assets/icons/dry_clean.svg',
        basePrice: 12.99,
        description: 'Professional dry cleaning service',
      ),
      const LaundryCategory(
        id: '3',
        name: 'Ironing',
        icon: 'assets/icons/iron.svg',
        basePrice: 3.99,
        description: 'Professional ironing service',
      ),
      const LaundryCategory(
        id: '4',
        name: 'Express Wash',
        icon: 'assets/icons/express.svg',
        basePrice: 8.99,
        description: 'Same day express wash service',
      ),
    ];
  }
}
