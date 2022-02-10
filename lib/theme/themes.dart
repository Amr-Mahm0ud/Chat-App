import 'package:flutter/material.dart';

import 'constants.dart';

const appBarTheme = AppBarTheme(
    centerTitle: false, elevation: 0, backgroundColor: kPrimaryColor);

class Themes {
  static ThemeData lightTheme = ThemeData.light().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: kContentColorLight),
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kContentColorDark,
      elevation: 5,
      selectedItemColor: Colors.black54,
      unselectedItemColor: kContentColorLight.withOpacity(0.32),
      selectedIconTheme: const IconThemeData(color: kPrimaryColor),
    ),
  );

  static ThemeData darkTheme = ThemeData.dark().copyWith(
    primaryColor: kPrimaryColor,
    scaffoldBackgroundColor: kContentColorLight,
    appBarTheme: appBarTheme,
    iconTheme: const IconThemeData(color: kContentColorDark),
    colorScheme: const ColorScheme.dark().copyWith(
      primary: kPrimaryColor,
      error: kErrorColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: kContentColorLight,
      elevation: 5,
      selectedItemColor: Colors.white70,
      unselectedItemColor: kContentColorDark.withOpacity(0.32),
      selectedIconTheme: const IconThemeData(color: kPrimaryColor),
    ),
  );
}
