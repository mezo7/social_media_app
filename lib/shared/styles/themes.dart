import 'package:applecation/shared/styles/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';



ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  primarySwatch: Colors.cyan,
  highlightColor: defualtColor,
  primaryColor: Colors.white,
  primaryColorLight: Colors.white,
  fontFamily: 'Jannah',
  backgroundColor: Colors.black,
  secondaryHeaderColor: Colors.grey[600],
  appBarTheme:  AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarIconBrightness: Brightness.light,
    ),
    backgroundColor: Colors.black,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.white,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: defualtColor,
    ),
  ),
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defualtColor,
    elevation: 40.0,
    backgroundColor: Colors.black,
    unselectedItemColor: Colors.grey,
  ),
  textTheme:  TextTheme(
    bodyText1: TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w800,
      color: Colors.white,
    ),
    subtitle1: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.3
    ),
    subtitle2: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: Colors.white,
    ),
    caption: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.white,
    ),

  ),

);
ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.cyan,
  highlightColor: defualtColor,
  primaryColor: Colors.black,
  fontFamily: 'Jannah',
  backgroundColor: Colors.white,
  secondaryHeaderColor: Colors.grey[600],
  primaryColorLight: Colors.black,
  appBarTheme:  AppBarTheme(
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    backgroundColor: Colors.white,
    elevation: 0.0,
    titleTextStyle: TextStyle(
      fontFamily: 'Jannah',
      color: Colors.black,
      fontSize: 20.0,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: defualtColor,
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
  bottomNavigationBarTheme:  BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defualtColor,
    elevation: 40.0,
  ),
  textTheme:  TextTheme(
    bodyText1: TextStyle(
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    bodyText2: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w800,
      color: Colors.black,
    ),
    subtitle1: TextStyle(
      fontSize: 14.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      height: 1.3
    ),
    subtitle2: TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    ),
    caption: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.w600,
        color: Colors.black,
    ),
  ),
);
