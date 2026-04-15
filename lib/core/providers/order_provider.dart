import 'package:flutter/material.dart';
import 'package:laundry_app/features/orders/domain/models/order.dart';
import 'package:laundry_app/features/orders/domain/models/laundry_category.dart';
import 'package:laundry_app/features/orders/data/repositories/order_repository_impl.dart';
import 'package:laundry_app/core/services/api_services.dart';

class OrderProvider with ChangeNotifier {
  final OrderRepositoryImpl _repository;

  List<Order> _orders = [];
  List<LaundryCategory> _categories = [];
  bool _isLoading = false;
  Order? _currentCart;

  List<Order> get orders => _orders;
  List<LaundryCategory> get categories => _categories;
  bool get isLoading => _isLoading;
  Order? get currentCart => _currentCart;

  OrderProvider()
      : _repository = OrderRepositoryImpl(apiService: MockApiService()) {
    _loadData();
  }

  Future<void> _loadData() async {
    await Future.wait([
      getOrders(),
      loadCategories(),
    ]);
  }

  Future<void> getOrders() async {
    _isLoading = true;
    notifyListeners();

    try {
      final authProvider = getCurrentUserId(); // Stub, use auth later
      _orders = await _repository.getOrders('1'); // mock user
    } catch (e) {
      _orders = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCategories() async {
    _categories = _repository.getCategories();
    notifyListeners();
  }

  Future<void> addToCart(LaundryCategory category, double weight) async {
    _currentCart = Order(
      id: '',
      userId: '1',
      category: category,
      weight: weight,
      totalPrice: category.basePrice * weight,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
    );
    notifyListeners();
  }

  Future<void> createOrder() async {
    if (_currentCart != null) {
      _isLoading = true;
      notifyListeners();

      final order = await _repository.createOrder(_currentCart!);
      _orders.insert(0, order);
      _currentCart = null;
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    final order = _orders.firstWhere((o) => o.id == orderId);
    final updatedOrder =
        order.copyWith(status: status, updatedAt: DateTime.now());
    await _repository.updateOrder(updatedOrder);
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index != -1) {
      _orders[index] = updatedOrder;
      notifyListeners();
    }
  }

  String getCurrentUserId() {
    // Integrate with AuthProvider later
    return '1';
  }
}
