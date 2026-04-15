import 'package:equatable/equatable.dart';
import 'package:laundry_app/features/orders/domain/models/laundry_category.dart';

enum OrderStatus {
  pending,
  confirmed,
  washing,
  drying,
  ironing,
  ready,
  delivered,
  cancelled
}

class Order extends Equatable {
  final String id;
  final String userId;
  final LaundryCategory category;
  final double weight;
  final double totalPrice;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? pickupAddress;
  final String? paymentMethod;

  const Order({
    required this.id,
    required this.userId,
    required this.category,
    required this.weight,
    required this.totalPrice,
    required this.status,
    required this.createdAt,
    this.updatedAt,
    this.pickupAddress,
    this.paymentMethod,
  });

  Order copyWith({
    String? id,
    String? userId,
    LaundryCategory? category,
    double? weight,
    double? totalPrice,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? pickupAddress,
    String? paymentMethod,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      category: category ?? this.category,
      weight: weight ?? this.weight,
      totalPrice: totalPrice ?? this.totalPrice,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      pickupAddress: pickupAddress ?? this.pickupAddress,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  factory Order.empty() {
    return Order(
      id: '',
      userId: '',
      category: LaundryCategory.empty(),
      weight: 0.0,
      totalPrice: 0.0,
      status: OrderStatus.pending,
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'category': category.toJson(),
      'weight': weight,
      'totalPrice': totalPrice,
      'status': status.name,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'pickupAddress': pickupAddress,
      'paymentMethod': paymentMethod,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      category: LaundryCategory.fromJson(json['category'] ?? {}),
      weight: (json['weight'] as num?)?.toDouble() ?? 0.0,
      totalPrice: (json['totalPrice'] as num?)?.toDouble() ?? 0.0,
      status: OrderStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => OrderStatus.pending,
      ),
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt:
          json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
      pickupAddress: json['pickupAddress'],
      paymentMethod: json['paymentMethod'],
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        category,
        weight,
        totalPrice,
        status,
        createdAt,
        updatedAt,
        pickupAddress,
        paymentMethod
      ];
}
