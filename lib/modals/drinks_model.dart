import 'package:flutter/material.dart';

class DrinksModel {
  final String title;
  final double price;
  final String imagePath;
  final Color topBackgroundColor;
  final Color bottomBackgroundColor;
  final Color buttonColor;
  final Color textColor;
  final double rating;
  final String type;
  final String description;

  DrinksModel({
    required this.title,
    required this.type,
    required this.price,
    required this.imagePath,
    required this.topBackgroundColor,
    required this.bottomBackgroundColor,
    required this.buttonColor,
    this.textColor = Colors.black,
    this.rating = 5.0,
    this.description = '',
  });
}
