import 'package:flutter/material.dart';

class Theming {
  static Color mainGrey = const Color(0xFFd8e1e4);
  static Color mainBlack = const Color.fromARGB(255, 10, 10, 10);

  static Color mainWhite = const Color(0xFFFFFFFF);
  static TextStyle mainTextStyle = const TextStyle(
      fontFamily: "MainFont",
      fontSize: 30,
      fontWeight: FontWeight.w800,
      color: Color.fromARGB(255, 0, 0, 0));
  static const TextStyle titleMedium = TextStyle(
      fontFamily: "MainFont",
      fontSize: 15,
      fontWeight: FontWeight.w800,
      color: Colors.grey);
  static const TextStyle body1 = TextStyle(
      fontFamily: "MainFont",
      fontSize: 14,
      fontWeight: FontWeight.w800,
      color: Color.fromARGB(255, 0, 0, 0));

  // static const TextStyle body2 = TextStyle(
  //     fontFamily: "MainFont",
  //     fontSize: 14,
  //     fontWeight: FontWeight.w500,
  //     color: Color.fromARGB(255, 0, 0, 0));

  static ThemeData mainTheme = ThemeData(
      backgroundColor: mainWhite,
      scaffoldBackgroundColor: mainWhite,
      primaryColor: mainBlack,
      shadowColor: mainGrey,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: mainBlack,
        onPrimary: Colors.green,
        secondary: mainWhite,
        onSecondary: Colors.black38,
        background: Colors.blue,
        onBackground: Colors.white70,
        onError: Colors.red.shade400,
        error: Colors.red.shade700,
        surface: Colors.orange.shade200,
        onSurface: Colors.orange.shade600,
      ),
      textTheme: TextTheme(
        titleLarge: mainTextStyle,
        titleMedium: titleMedium,
        bodySmall: body1,
      ));
}
