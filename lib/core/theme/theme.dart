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
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed),
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
        onSecondary: const Color.fromARGB(255, 207, 207, 207),
        onPrimaryContainer: const Color.fromARGB(221, 236, 236, 236),
        onSecondaryContainer: const Color.fromARGB(255, 240, 240, 240),
        secondaryContainer: const Color.fromARGB(255, 237, 237, 237),
        surfaceContainerHigh: const Color.fromARGB(255, 26, 77, 194),
        surfaceContainerLow: const Color.fromARGB(255, 29, 29, 29),
        surfaceContainer: Color.fromARGB(255, 247, 247, 247),
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
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed),
    colorScheme: ColorScheme.fromSeed(
        onSecondary: const Color.fromARGB(255, 42, 42, 42),
        onSecondaryContainer: const Color.fromARGB(255, 32, 32, 32),
        onPrimaryContainer: const Color.fromARGB(221, 70, 70, 70),
        secondaryContainer: const Color.fromARGB(255, 68, 68, 68),
        surfaceContainerHigh: const Color.fromARGB(255, 15, 45, 135),
        surfaceContainerLow: const Color.fromARGB(255, 46, 46, 46),
        surfaceContainer: Color.fromARGB(255, 19, 19, 19),
        seedColor: const Color.fromARGB(255, 0, 94, 255),
        brightness: Brightness.dark));
