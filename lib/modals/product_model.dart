import 'package:flutter/material.dart';

class ProductsModel {
  final String? id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final Color topBackgroundColor;
  final Color bottomBackgroundColor;
  final Color buttonColor;
  final Color textColor;
  final double rating;
  final String type;

  ProductsModel({
    this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.topBackgroundColor = const Color(0xff8c3332),
    this.bottomBackgroundColor = const Color(0xFFFFFFFF),
    this.buttonColor = const Color(0xff8c3332),
    this.textColor = const Color(0xFF000000),
    this.rating = 5.0,
    this.type = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'topBackgroundColor': topBackgroundColor.value,
      'bottomBackgroundColor': bottomBackgroundColor.value,
      'buttonColor': buttonColor.value,
      'textColor': textColor.value,
      'rating': rating,
      'type': type,
    };
  }

  factory ProductsModel.fromMap(Map<String, dynamic> map, String id) {
    return ProductsModel(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      topBackgroundColor: Color(map['topBackgroundColor'] ?? 0xff8c3332),
      bottomBackgroundColor: Color(map['bottomBackgroundColor'] ?? 0xFFFFFFFF),
      buttonColor: Color(map['buttonColor'] ?? 0xff8c3332),
      textColor: Color(map['textColor'] ?? 0xFF000000),
      rating: (map['rating'] ?? 5.0).toDouble(),
      type: map['type'] ?? '',
    );
  }
}
