import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String userId;
  final String serviceName;
  final OrderStatus status;
  final double totalAmount;
  final List<OrderItem> items;
  final DateTime pickupDate;
  final DateTime deliveryDate;
  final String address;
  final String? notes;
  final String? paymentMethod;
  final DateTime createdAt;

  const Order({
    required this.id,
    required this.userId,
    required this.serviceName,
    required this.status,
    required this.totalAmount,
    required this.items,
    required this.pickupDate,
    required this.deliveryDate,
    required this.address,
    this.notes,
    this.paymentMethod,
    required this.createdAt,
  });

  factory Order.empty() {
    return Order(
      id: '',
      userId: '',
      serviceName: '',
      status: OrderStatus.pending,
      totalAmount: 0,
      items: [],
      pickupDate: DateTime.now(),
      deliveryDate: DateTime.now(),
      address: '',
      createdAt: DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'serviceName': serviceName,
      'status': status.index,
      'totalAmount': totalAmount,
      'items': items.map((item) => item.toJson()).toList(),
      'pickupDate': pickupDate.toIso8601String(),
      'deliveryDate': deliveryDate.toIso8601String(),
      'address': address,
      'notes': notes,
      'paymentMethod': paymentMethod,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      serviceName: json['serviceName'] ?? '',
      status: OrderStatus.values[json['status'] ?? 0],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      items: (json['items'] as List?)
              ?.map((item) => OrderItem.fromJson(item))
              .toList() ??
          [],
      pickupDate: DateTime.parse(json['pickupDate']),
      deliveryDate: DateTime.parse(json['deliveryDate']),
      address: json['address'] ?? '',
      notes: json['notes'],
      paymentMethod: json['paymentMethod'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Order copyWith({
    String? id,
    String? userId,
    String? serviceName,
    OrderStatus? status,
    double? totalAmount,
    List<OrderItem>? items,
    DateTime? pickupDate,
    DateTime? deliveryDate,
    String? address,
    String? notes,
    String? paymentMethod,
    DateTime? createdAt,
  }) {
    return Order(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      serviceName: serviceName ?? this.serviceName,
      status: status ?? this.status,
      totalAmount: totalAmount ?? this.totalAmount,
      items: items ?? this.items,
      pickupDate: pickupDate ?? this.pickupDate,
      deliveryDate: deliveryDate ?? this.deliveryDate,
      address: address ?? this.address,
      notes: notes ?? this.notes,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        serviceName,
        status,
        totalAmount,
        items,
        pickupDate,
        deliveryDate,
        address,
        notes,
        paymentMethod,
        createdAt,
      ];
}

class OrderItem extends Equatable {
  final String name;
  final int quantity;
  final double price;

  const OrderItem({
    required this.name,
    required this.quantity,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      name: json['name'] ?? '',
      quantity: json['quantity'] ?? 0,
      price: (json['price'] ?? 0).toDouble(),
    );
  }

  @override
  List<Object?> get props => [name, quantity, price];
}

enum OrderStatus {
  pending,
  confirmed,
  processing,
  ready,
  delivered,
  completed,
}