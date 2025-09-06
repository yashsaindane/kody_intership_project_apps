import 'package:hive/hive.dart';

part 'hive_cart_model.g.dart';

@HiveType(typeId: 0)
enum ProductStatus {
  @HiveField(0)
  all,
  @HiveField(1)
  pending,
  @HiveField(2)
  shipped,
  @HiveField(3)
  delivered,
}

@HiveType(typeId: 1)
class CartProduct extends HiveObject {
  @HiveField(0)
  final int productId;

  @HiveField(1)
  final String productName;

  @HiveField(2)
  final double productPrice;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  final List<String> imageUrl;

  @HiveField(5)
  final ProductStatus status;

  @HiveField(6)
  final DateTime dateTime;

  @HiveField(7)
  final String userEmail;

  CartProduct({
    required this.productId,
    required this.productName,
    required this.productPrice,
    required this.quantity,
    required this.imageUrl,
    required this.status,
    required this.dateTime,
    required this.userEmail,
  });

  factory CartProduct.fromJson(Map<String, dynamic> json) {
    return CartProduct(
      productId: json['productId'],
      productName: json['productName'],
      productPrice: json['productPrice'],
      quantity: json['quantity'],
      imageUrl: List<String>.from(json['imageUrl']),
      status: ProductStatus.values[json['status']],
      dateTime: DateTime.parse(json['dateTime']),
      userEmail: json['userEmail'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'productName': productName,
      'productPrice': productPrice,
      'quantity': quantity,
      'imageUrl': imageUrl,
      'status': status.index,
      'dateTime': dateTime.toIso8601String(),
      'userEmail': userEmail,
    };
  }

  // CopyWith method
  CartProduct copyWith({
    int? productId,
    String? productName,
    double? productPrice,
    int? quantity,
    List<String>? imageUrl,
    ProductStatus? status,
    DateTime? dateTime,
    String? userEmail,
  }) {
    return CartProduct(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      productPrice: productPrice ?? this.productPrice,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      status: status ?? this.status,
      dateTime: dateTime ?? this.dateTime,
      userEmail: userEmail ?? this.userEmail,
    );
  }
}
