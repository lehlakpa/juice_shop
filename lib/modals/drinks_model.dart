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

  DrinksModel({
    required this.title,
    required this.price,
    required this.imagePath,
    required this.topBackgroundColor,
    required this.bottomBackgroundColor,
    required this.buttonColor,
    this.textColor = Colors.black,
    this.rating = 5.0,
  });
}

final List<DrinksModel> drinks = [
  // 🍓 STRAWBERRY
  DrinksModel(
    title: 'Strawberry',
    price: 10,
    imagePath: 'assets/images/staberry_image.png',

    // Dark red background
    topBackgroundColor: const Color(0xFF5A2528),

    // Pink/red bottom card
    bottomBackgroundColor: const Color(0xFFC9575B),

    // Light pink button
    buttonColor: const Color(0xFFEFA1A3),

    textColor: Colors.black,
    rating: 4.0,
  ),

  // 🍫 CHOCOLATE
  DrinksModel(
    title: 'Chocolate',
    price: 15,
    imagePath: 'assets/images/choclate_image.png',

    // Cream / beige top
    topBackgroundColor: const Color(0xFFC3AD94),

    // Warm cream/yellow bottom card
    bottomBackgroundColor: const Color(0xFFFFD487),

    // Orange button
    buttonColor: const Color(0xFFF39A55),

    textColor: Colors.black,
    rating: 5.0,
  ),

  // 🥭 MANGO
  DrinksModel(
    title: 'Mango',
    price: 20,
    imagePath: 'assets/images/mango_juice.png',

    topBackgroundColor: const Color(0xFFFFD447),
    bottomBackgroundColor: const Color(0xFFEF9500),
    buttonColor: const Color(0xFFFFC928),
    textColor: Colors.black,
    rating: 5.0,
  ),

  DrinksModel(
    title: 'Watermelon',
    price: 18,
    imagePath: 'assets/images/watermilan_juice.png',
    topBackgroundColor: const Color(0xFF6E292D),
    bottomBackgroundColor: const Color(0xFFE85D68),
    buttonColor: const Color(0xFFF5A0A5),

    textColor: Colors.black,
    rating: 4.5,
  ),

  DrinksModel(
    title: 'Pomegranate',
    price: 18,
    imagePath: 'assets/images/pomgranate_juice.png',
    topBackgroundColor: const Color(0xFF5B171E),
    bottomBackgroundColor: const Color(0xFFC72F45),
    buttonColor: const Color(0xFFE97983),
    textColor: Colors.black,
    rating: 4.5,
  ),

  DrinksModel(
    title: 'Apple',
    price: 16,
    imagePath: 'assets/images/apple_juice.png',

    topBackgroundColor: const Color(0xFF7A3B2E),
    bottomBackgroundColor: const Color(0xFFE5A33A),
    buttonColor: const Color(0xFFF5C45A),
    textColor: Colors.black,
    rating: 4.5,
  ),

  DrinksModel(
    title: 'Lemon Tea',
    price: 12,
    imagePath: 'assets/images/lemoan_tea.png',

    topBackgroundColor: const Color(0xFF5A3A24),
    bottomBackgroundColor: const Color(0xFFD98B2B),
    buttonColor: const Color(0xFFF3B83F),
    textColor: Colors.black,
    rating: 4.5,
  ),
];
