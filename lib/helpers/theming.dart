import 'package:flutter/material.dart';

class CustomTheming {
  static final ThemeData theme = ThemeData();

  static ThemeData get lightTheme {
    return ThemeData(
        primaryColor: const Color.fromRGBO(31, 0, 85, 1),
        splashColor: const Color.fromRGBO(200, 128, 255, 1),
        dividerColor: Colors.white,
        canvasColor: Colors.white,
        //colorSchemeSeed: Colors.white,
        appBarTheme: const AppBarTheme(
          elevation: 2,
          backgroundColor: Color.fromRGBO(31, 0, 85, 1),
        ),
        colorScheme: theme.colorScheme
            .copyWith(secondary: const Color.fromRGBO(200, 128, 255, 1)),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Montserrat',
        buttonTheme: ButtonThemeData(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.0)),
          buttonColor: const Color.fromRGBO(200, 128, 255, 1),
        ));
  }
}
