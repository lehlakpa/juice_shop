import 'package:flutter/material.dart';

abstract class AppColors {
  // Backgrounds
  static const Color darkBackground = Color(
    0xFF5A2A2A,
  ); // Main dark maroon background
  static const Color cardLightPink = Color(
    0xFFFBE3E3,
  ); // Card container background for menu items

  // Theme Variation Backgrounds (Detail Screens)
  static const Color chocolateBg = Color(
    0xFFF7CF8B,
  ); // Warm beige/cream for Chocolate
  static const Color mangoBg = Color(0xFFFFC83B); // Golden yellow for Mango
  static const Color strawberryBg = Color(
    0xFFBC4A4D,
  ); // Deep rose/pinkish-red for Strawberry

  // Buttons & Accents
  static const Color chocolateButton = Color(
    0xFFEF9853,
  ); // Orange button on chocolate screen
  static const Color mangoButton = Color(
    0xFFE59400,
  ); // Deep amber button on mango screen
  static const Color strawberryButton = Color(
    0xFFEEA1A3,
  ); // Light pinkish button on strawberry screen

  // Elements & Indicators
  static const Color activeTabBackground = Color(
    0xFF8B4B4B,
  ); // Selected vertical tab capsule
  static const Color favoriteHeartBg = Color(
    0xFFC02A30,
  ); // Dark red heart button circle
  static const Color favoriteHeartIcon = Color(0xFFFFFFFF); // White heart icon
  static const Color starRating = Color(0xFFFFEB3B); // Yellow rating stars
  static const Color ratingBadgeBg = Color(
    0xFFFFFFFF,
  ); // White rating chip background

  // Text Colors
  static const Color textPrimaryDark = Color(
    0xFF1E1E1E,
  ); // Main dark text for light cards/containers
  static const Color textPrimaryLight = Color(
    0xFFFFFFFF,
  ); // White header/title text on dark bg
  static const Color textMuted = Color(
    0xFF8E8E8E,
  ); // Unselected tab / secondary text
}
