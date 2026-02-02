import 'package:flutter/material.dart';

class PosProduct {
  PosProduct({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.description,
    required this.price,
    required this.stock,
    required this.icon,
    this.quantity = 1,
  });

  final String id;
  final String categoryId;
  final String title;
  final String description;
  final double price;
  final int stock;
  final IconData icon;
  int quantity;

  factory PosProduct.fromJson(Map<String, dynamic> json) {
    return PosProduct(
      id: json['id'] as String,
      categoryId: json['categoryId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      stock: json['stock'] as int,
      icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
    );
  }

  factory PosProduct.copyWith(
    PosProduct product, {
    String? id,
    String? categoryId,
    String? title,
    String? description,
    double? price,
    int? stock,
    IconData? icon,
    int? quantity,
  }) {
    return PosProduct(
      id: id ?? product.id,
      categoryId: categoryId ?? product.categoryId,
      title: title ?? product.title,
      description: description ?? product.description,
      price: price ?? product.price,
      stock: stock ?? product.stock,
      icon: icon ?? product.icon,
      quantity: quantity ?? product.quantity,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'categoryId': categoryId,
      'title': title,
      'description': description,
      'price': price,
      'stock': stock,
      'icon': icon.codePoint,
    };
  }
}
