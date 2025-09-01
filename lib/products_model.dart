// To parse this JSON data, do
//
//     final productList = productListFromJson(jsonString);

import 'package:hive/hive.dart';
import 'dart:convert';

part 'products_model.g.dart';

ProductList productListFromJson(String str) => ProductList.fromJson(json.decode(str));

String productListToJson(ProductList data) => json.encode(data.toJson());

@HiveType(typeId: 1)
class ProductList {
  @HiveField(1)
  List<Product> products;

  ProductList({
    required this.products,
  });

  factory ProductList.fromJson(Map<String, dynamic> json) => ProductList(
    products: List<Product>.from(json["products"].map((x) => Product.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "products": List<dynamic>.from(products.map((x) => x.toJson())),
  };
}

@HiveType(typeId: 2)
class Product {
  @HiveField(1)
  int id;
  @HiveField(2)
  String imagePath;
  @HiveField(3)
  double name;
  @HiveField(4)
  String description;
  @HiveField(5)
  double price;

  Product({
    required this.id,
    required this.imagePath,
    required this.description,
    required this.price,
    required this.name,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    description: json["description"],
    price: json["price"]?.toDouble(),
    name: json["name"],
    imagePath: json["https://static.nike.com/a/images/t_PDP_1728_v1/f_auto,q_auto:eco/735593be-d93f-4159-ba15-516a69d3f53f/NIKE+SB+PS8.png"]
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "description": description,
    "price": price,
    "name": name,
  };
}





//boxes in utils