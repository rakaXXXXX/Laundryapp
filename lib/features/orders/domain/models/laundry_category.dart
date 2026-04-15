import 'package:equatable/equatable.dart';

class LaundryCategory extends Equatable {
  final String id;
  final String name;
  final String icon;
  final double basePrice;
  final String description;

  const LaundryCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.basePrice,
    required this.description,
  });

  factory LaundryCategory.empty() {
    return const LaundryCategory(
      id: '',
      name: '',
      icon: '',
      basePrice: 0.0,
      description: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'icon': icon,
      'basePrice': basePrice,
      'description': description,
    };
  }

  factory LaundryCategory.fromJson(Map<String, dynamic> json) {
    return LaundryCategory(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      basePrice: (json['basePrice'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
    );
  }

  @override
  List<Object?> get props => [id, name, icon, basePrice, description];
}
