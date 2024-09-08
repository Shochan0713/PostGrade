import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: Colors.teal,
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(
        bodyLarge: const TextStyle(color: Colors.black),
        bodyMedium: TextStyle(color: Colors.grey[600]),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.teal,
        titleTextStyle: TextStyle(color: Colors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.teal,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: Colors.grey[900],
      scaffoldBackgroundColor: Colors.white, // 背景色
      textTheme: TextTheme(
        bodyLarge: const TextStyle(color: Colors.white),
        bodyMedium: TextStyle(color: Colors.grey[300]),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[900],
        titleTextStyle: const TextStyle(color: Colors.white),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Colors.blueGrey,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}
