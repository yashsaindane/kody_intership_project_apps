// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_cart_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CartProductAdapter extends TypeAdapter<CartProduct> {
  @override
  final int typeId = 1;

  @override
  CartProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CartProduct(
      productId: fields[0] as int,
      productName: fields[1] as String,
      productPrice: fields[2] as double,
      quantity: fields[3] as int,
      imageUrl: (fields[4] as List).cast<String>(),
      status: fields[5] as ProductStatus,
      dateTime: fields[6] as DateTime,
      userEmail: fields[7] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CartProduct obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.productName)
      ..writeByte(2)
      ..write(obj.productPrice)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.imageUrl)
      ..writeByte(5)
      ..write(obj.status)
      ..writeByte(6)
      ..write(obj.dateTime)
      ..writeByte(7)
      ..write(obj.userEmail);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CartProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ProductStatusAdapter extends TypeAdapter<ProductStatus> {
  @override
  final int typeId = 0;

  @override
  ProductStatus read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return ProductStatus.all;
      case 1:
        return ProductStatus.pending;
      case 2:
        return ProductStatus.shipped;
      case 3:
        return ProductStatus.delivered;
      default:
        return ProductStatus.all;
    }
  }

  @override
  void write(BinaryWriter writer, ProductStatus obj) {
    switch (obj) {
      case ProductStatus.all:
        writer.writeByte(0);
        break;
      case ProductStatus.pending:
        writer.writeByte(1);
        break;
      case ProductStatus.shipped:
        writer.writeByte(2);
        break;
      case ProductStatus.delivered:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductStatusAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
