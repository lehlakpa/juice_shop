import 'package:coffee_shop/constants/constant_colors/app_colors.dart';
import 'package:flutter/material.dart';

abstract class AppTextStyles {
  static const TextStyle welcomeHeader = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryLight,
    letterSpacing: 0.5,
  );
}
//  Text("choclate",style:apptextstyle.welcomeheader); use