import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    brightness: Brightness.light,
    splashColor: Colors.transparent,
    cardTheme: CardTheme(
      color: const Color.fromARGB(255, 248, 248, 248),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: Colors.black),
      bodyMedium: TextStyle(color: Colors.black),
      bodySmall: TextStyle(color: Colors.black),
      titleLarge: TextStyle(color: Colors.black),
      titleMedium: TextStyle(color: Colors.black),
      titleSmall: TextStyle(color: Colors.black),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue, type: BottomNavigationBarType.fixed),
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
        surfaceContainerHigh: const Color.fromARGB(255, 0, 76, 255),
        surfaceContainerLow: const Color.fromARGB(255, 128, 0, 255),
        surfaceContainer: Color.fromARGB(255, 234, 234, 234),
        seedColor: Colors.blue,
        brightness: Brightness.light));

final ThemeData blackTheme = ThemeData(
    cardTheme: CardTheme(
      color: const Color.fromARGB(255, 0, 0, 0),
    ),
    scaffoldBackgroundColor: Colors.black,
    useMaterial3: true,
    brightness: Brightness.dark,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white),
      titleLarge: TextStyle(color: Colors.white),
      titleMedium: TextStyle(color: Colors.white),
      titleSmall: TextStyle(color: Colors.white),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Colors.blue, type: BottomNavigationBarType.fixed),
    colorScheme: ColorScheme.fromSeed(
        surfaceContainerHigh: const Color.fromARGB(255, 0, 21, 159),
        surfaceContainerLow: const Color.fromARGB(255, 90, 0, 146),
        surfaceContainer: Color.fromARGB(255, 19, 19, 19),
        seedColor: const Color.fromARGB(255, 0, 94, 255),
        brightness: Brightness.dark));
