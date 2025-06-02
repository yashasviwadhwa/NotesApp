import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    centerTitle: true,
    foregroundColor: Colors.black,
    iconTheme: IconThemeData(color: Colors.black),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF2C5364),
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFFE0E0E0),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    hintStyle: TextStyle(color: Colors.black38),
    labelStyle: TextStyle(color: Colors.black87),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.black),
  iconTheme: const IconThemeData(color: Colors.black87),
  dividerColor: Colors.black12,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.black87),
    bodyMedium: TextStyle(color: Colors.black54),
    titleLarge: TextStyle(color: Colors.black),
  ),
  colorScheme: const ColorScheme.light(
    primary: Color(0xFF2C5364),
    secondary: Colors.teal,
    error: Colors.red,
    background: Color(0xFFF5F5F5),
    surface: Color(0xFFE0E0E0),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.black,
    onSurface: Colors.black,
    onError: Colors.white,
  ),
  cardColor: Colors.white,
  hintColor: Colors.grey,
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  scaffoldBackgroundColor: Colors.transparent,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: true,
    foregroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.white),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF2C5364),
      foregroundColor: Colors.white,
      textStyle: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    filled: true,
    fillColor: Color(0xFF2C3035),
    border: OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(Radius.circular(12)),
    ),
    hintStyle: TextStyle(color: Colors.white38),
    labelStyle: TextStyle(color: Colors.white70),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(color: Colors.white),
  iconTheme: const IconThemeData(color: Colors.white70),
  dividerColor: Colors.white24,
  textTheme: const TextTheme(
    bodyLarge: TextStyle(color: Colors.white70),
    bodyMedium: TextStyle(color: Colors.white54),
    titleLarge: TextStyle(color: Colors.grey),
  ),
  colorScheme: const ColorScheme.dark(
    primary: Color(0xFF2C5364),
    secondary: Colors.tealAccent,
    error: Colors.red,
    background: Color(0xFF121212),
    surface: Color(0xFF203A43),
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onBackground: Colors.white,
    onSurface: Colors.white,
    onError: Colors.white,
  ),
  cardColor: Colors.grey,
  hintColor: Colors.grey,
);
