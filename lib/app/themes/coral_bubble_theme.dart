import 'package:dairy_app/app/themes/theme_models.dart';
import 'package:flutter/material.dart';

class CoralBubble {
  static ThemeData getTheme() {
    return ThemeData(
      // used only for elements whose colors can't be directly controlled
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink).copyWith(
        secondary: Colors.pinkAccent,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.pink[300],
          backgroundColor: Colors.purple,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          side: BorderSide(
            color: Colors.black.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.purple,
          textStyle: const TextStyle(
            fontSize: 16,
            color: Colors.purple,
          ),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: Colors.pinkAccent,
        elevation: 4,
      ),

      // theme extensions
      extensions: <ThemeExtension<dynamic>>{
        AdditionalThemeExtensions(
          backgroundImage: "assets/images/coral-bubbles.png",
          linkColor: Colors.pink[300]!,
          errorTextColor: Colors.pink[200]!,
        )
      },
    );
  }
}