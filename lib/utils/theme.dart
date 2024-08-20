import 'package:flutter/material.dart';

import 'colors.dart';

class AppThemes {
  static ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,


      primaryColor: primaryColor,
      inputDecorationTheme: const InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
        labelStyle: TextStyle(color: Colors.white60),
        iconColor: Colors.white,
        prefixIconColor: Colors.white,
        suffixIconColor: Colors.white,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white70, width: 2.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 3.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 3.0),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),



  );

}