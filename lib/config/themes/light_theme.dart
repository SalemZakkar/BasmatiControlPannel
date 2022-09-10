import 'package:flutter/material.dart';
import 'package:web_basmati/config/themes/transitions.dart';

import 'constant.dart';

ThemeData lightTheme = ThemeData(
  fontFamily: "Cairo",
  pageTransitionsTheme: PageTransitionsTheme(
      builders: {TargetPlatform.windows: SlideHorizontalTransitionBuilder()}),
  primaryColor: primaryColor,
  primarySwatch: Colors.blue,
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: primaryColor
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
        color: primaryColor,
        fontSize: 25,
        fontFamily: "Cairo",
        fontWeight: FontWeight.w600),
    centerTitle: false,
    backgroundColor: const Color.fromRGBO(249, 249, 249, 1.0),
    iconTheme: IconThemeData(color: primaryColor),
    shadowColor: const Color.fromRGBO(249, 249, 249, 0.0),
  ),
  errorColor: Colors.red,
  cardColor: Colors.white,
  scaffoldBackgroundColor: const Color.fromRGBO(249, 249, 249, 1.0),
  listTileTheme: ListTileThemeData(
    iconColor: primaryColor,
  ),
  inputDecorationTheme: InputDecorationTheme(
    prefixIconColor: primaryColor,
    hintStyle: const TextStyle(color: Colors.grey),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.all(10),
    enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white)),
    // UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF0566A5))),
    focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.white)),
    //     UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF0566A5))),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.white),
    ),
    //     UnderlineInputBorder(borderSide: BorderSide(color: Color(0xFF0566A5))),
  ),
  textSelectionTheme: TextSelectionThemeData(
      selectionColor: primaryColor.withOpacity(0.4),
      cursorColor: primaryColor,
      selectionHandleColor: primaryColor),
  dividerColor: Colors.grey,
  radioTheme:
      RadioThemeData(fillColor: MaterialStateProperty.all(primaryColor)),
  textTheme: TextTheme(
      headline1:
          TextStyle(color: primaryColor, fontFamily: "Cairo", fontSize: 20),
      // headline2: TextStyle(color: Colors.black , fontFamily: "Cairo"),
      // headline3: TextStyle(color: Colors.grey , fontFamily: "Cairo"),
      headline2: const TextStyle(
          color: Colors.black,
          fontFamily: "Cairo",
          fontSize: 15,
          overflow: TextOverflow.ellipsis,
          fontWeight: FontWeight.w600),
      bodyText1: const TextStyle(
          color: Colors.white,
          fontFamily: "Cairo",
          overflow: TextOverflow.ellipsis),
      bodyText2: const TextStyle(
          color: Colors.grey,
          fontFamily: "Cairo",
          overflow: TextOverflow.ellipsis),
      subtitle1: const TextStyle(
          color: Colors.black,
          fontFamily: "Cairo",
          overflow: TextOverflow.ellipsis),
      caption: const TextStyle(
          color: Color.fromRGBO(188, 188, 241, 1.0), fontFamily: "Cairo")),
  iconTheme: IconThemeData(
    color: primaryColor,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    unselectedItemColor: primaryColor.withOpacity(0.4),
    selectedItemColor: primaryColor,
  ),
);
