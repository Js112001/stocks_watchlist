import 'package:flutter/material.dart';

class AppTextStyle {
  AppTextStyle._();

  static const TextStyle heading = TextStyle(fontSize: 18);
  static const TextStyle caption = TextStyle(fontSize: 12);
  static const TextStyle buttonBlack = TextStyle(color: Colors.black);
  static const TextStyle buttonWhite = TextStyle(color: Colors.white);

  static TextStyle price(Color color) => TextStyle(color: color);
}
