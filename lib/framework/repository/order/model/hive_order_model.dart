import 'package:hive/hive.dart';

import '../../cart/model/hive_cart_model.dart';

part 'hive_order_model.g.dart';

@HiveType(typeId: 2)
enum OrderStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  shipped,
  @HiveField(2)
  delivered,
}

@HiveType(typeId: 3)
class Order extends HiveObject {
  @HiveField(0)
  final List<CartProduct> products;

  @HiveField(1)
  final double totalPrice;

  @HiveField(2)
  final DateTime orderDate;

  @HiveField(3)
  OrderStatus status;

  @HiveField(4)
  final List<String> imageUrl;

  @HiveField(5)
  final String? userEmail;

  Order({
    required this.products,
    required this.totalPrice,
    required this.orderDate,
    required this.status,
    required this.imageUrl,
    this.userEmail,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      products: (json['products'] as List)
          .map((e) => CartProduct.fromJson(e))
          .toList(),
      totalPrice: json['totalPrice'],
      orderDate: DateTime.parse(json['orderDate']),
      status: OrderStatus.values[json['status']],
      imageUrl: List<String>.from(json['imageUrl']),
      userEmail: json['userEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'products': products.map((e) => e.toJson()).toList(),
      'totalPrice': totalPrice,
      'orderDate': orderDate.toIso8601String(),
      'status': status.index,
      'imageUrl': imageUrl,
      'userEmail': userEmail,
    };
  }

  Order copyWith({
    List<CartProduct>? products,
    double? totalPrice,
    DateTime? orderDate,
    OrderStatus? status,
    List<String>? imageUrl,
    String? userEmail,
  }) {
    return Order(
      products: products ?? this.products,
      totalPrice: totalPrice ?? this.totalPrice,
      orderDate: orderDate ?? this.orderDate,
      status: status ?? this.status,
      imageUrl: imageUrl ?? this.imageUrl,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}
