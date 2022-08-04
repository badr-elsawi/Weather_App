import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

  ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    backgroundColor: Colors.white.withOpacity(0.07),
    accentColor: Color(0xff0D85BA),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      backwardsCompatibility: false,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[700],
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.white,
        fontSize: 30,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: Colors.white,
        fontSize: 20,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        color: Colors.white,
        fontSize: 50,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w400,
      ),
      headline5: TextStyle(
        color: Colors.grey[700],
        fontSize: 18,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w400,
      ),
    ),
  );

//***************************************************

  ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.grey[200],
    backgroundColor: Colors.black.withOpacity(0.07),
    accentColor: Color(0xff0D85BA),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      backwardsCompatibility: false,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    ),
    iconTheme: IconThemeData(
      color: Colors.grey[500],
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        color: Colors.black,
        fontSize: 30,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w600,
      ),
      headline2: TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w600,
      ),
      headline3: TextStyle(
        color: Colors.black,
        fontSize: 18,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w400,
      ),
      headline4: TextStyle(
        color: Colors.black,
        fontSize: 50,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w400,
      ),
      headline5: TextStyle(
        color: Colors.grey[700],
        fontSize: 18,
        fontFamily: 'Montserrat-Bold',
        fontWeight: FontWeight.w400,
      ),
    ),
  );