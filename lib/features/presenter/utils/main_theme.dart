import 'package:flutter/material.dart';

ThemeData mainTheme() {
  const primaryColor = Color(0xFF25316F);
  const accentColor = Color(0xFF3B46DE);
  const backgroundColor = Color(0xFFE6E6E6);
  var disabledColor = Colors.grey[400];
  const textColor = Colors.white;

  var textTheme = TextTheme(
    headline1: TextStyle(
      color: primaryColor,
      fontSize: 32,
      fontWeight: FontWeight.bold,
    ),
    headline2: TextStyle(
      color: textColor,
      fontSize: 30,
      fontWeight: FontWeight.bold,
    ),
    headline3: TextStyle(
      color: accentColor,
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
    bodyText1: TextStyle(
      color: primaryColor,
      fontSize: 16,
    ),
    bodyText2: TextStyle(
      color: primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    overline: TextStyle(
      color: primaryColor,
      fontSize: 14,
      fontWeight: FontWeight.bold,
      letterSpacing: 0,
    ),
    caption: TextStyle(
      color: primaryColor,
      fontSize: 14,
    ),
    button: TextStyle(
      color: primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );

  return ThemeData(
    brightness: Brightness.light,
    primaryColor: primaryColor,
    accentColor: accentColor,
    disabledColor: disabledColor,
    scaffoldBackgroundColor: backgroundColor,
    canvasColor: backgroundColor,
    shadowColor: Colors.black12,
    textTheme: textTheme,
    iconTheme: IconThemeData(color: primaryColor),
    cardTheme: CardTheme(
      color: primaryColor,
      elevation: 5,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        primary: accentColor,
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.all(20),
        side: BorderSide(color: accentColor),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        primary: accentColor,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(15),
        primary: accentColor,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      floatingLabelBehavior: FloatingLabelBehavior.always,
      labelStyle: textTheme.bodyText2,
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: primaryColor),
      ),
    ),
    popupMenuTheme: PopupMenuThemeData(
      elevation: 2,
      color: backgroundColor,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: backgroundColor,
      elevation: 0,
    ),
  );
}
