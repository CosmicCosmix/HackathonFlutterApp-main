import 'package:flutter/material.dart';

String _appTheme = "lightCode";
LightCodeColors get appTheme => ThemeHelper().themeColor();
ThemeData get theme => ThemeHelper().themeData();

/// Helper class for managing themes and colors.

// ignore_for_file: must_be_immutable
class ThemeHelper {
  // A map of custom color themes supported by the app
  Map<String, LightCodeColors> _supportedCustomColor = {
    'lightCode': LightCodeColors()
  };

  // A map of color schemes supported by the app
  Map<String, ColorScheme> _supportedColorScheme = {
    'lightCode': ColorSchemes.lightCodeColorScheme
  };

  /// Changes the app theme to [_newTheme].
  void changeTheme(String _newTheme) {
    _appTheme = _newTheme;
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors _getThemeColors() {
    return _supportedCustomColor[_appTheme] ?? LightCodeColors();
  }

  /// Returns the current theme data.
  ThemeData _getThemeData() {
    var colorScheme =
        _supportedColorScheme[_appTheme] ?? ColorSchemes.lightCodeColorScheme;
    return ThemeData(
      visualDensity: VisualDensity.standard,
      colorScheme: colorScheme,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Color(0xFF000000),
      canvasColor: Color(0xFF000000),
      cardColor: Color(0xFF0A0A0A),
      dialogBackgroundColor: Color(0xFF0A0A0A),
      appBarTheme: AppBarTheme(
        backgroundColor: Color(0xFF000000),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Color(0xFF0A0A0A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1A1A1A)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF1A1A1A)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Color(0xFF6A62B6)),
        ),
        hintStyle: TextStyle(color: Color(0xFF666666)),
        labelStyle: TextStyle(color: Color(0xFF999999)),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Color(0xFF000000),
        selectedItemColor: Color(0xFF6A62B6),
        unselectedItemColor: Color(0xFF666666),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Color(0xFF6A62B6),
        foregroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: Colors.white),
        displayMedium: TextStyle(color: Colors.white),
        displaySmall: TextStyle(color: Colors.white),
        headlineMedium: TextStyle(color: Colors.white),
        headlineSmall: TextStyle(color: Colors.white),
        titleLarge: TextStyle(color: Colors.white),
        titleMedium: TextStyle(color: Colors.white),
        titleSmall: TextStyle(color: Colors.white),
        bodyLarge: TextStyle(color: Color(0xFFCCCCCC)),
        bodyMedium: TextStyle(color: Color(0xFFCCCCCC)),
        bodySmall: TextStyle(color: Color(0xFF999999)),
        labelLarge: TextStyle(color: Colors.white),
      ),
    );
  }

  /// Returns the lightCode colors for the current theme.
  LightCodeColors themeColor() => _getThemeColors();

  /// Returns the current theme data.
  ThemeData themeData() => _getThemeData();
}

class ColorSchemes {
  static final lightCodeColorScheme = ColorScheme.dark(
    primary: Color(0xFF6A62B6),
    surface: Color(0xFF121212),
    background: Color(0xFF000000),
    onPrimary: Colors.white,
    onSurface: Colors.white,
    onBackground: Colors.white,
  );
}

class LightCodeColors {
  // Dark Theme Colors - Pitch Black
  Color get black_900 => Color(0xFF000000);
  Color get black_800 => Color(0xFF0A0A0A);
  Color get black_700 => Color(0xFF121212);
  Color get black_600 => Color(0xFF1A1A1A);

  // Accent Colors
  Color get deep_purple_100 => Color(0xFF6A62B6).withOpacity(0.15);
  Color get deep_purple_300 => Color(0xFF958FD4);
  Color get indigo_400 => Color(0xFF6A62B6);
  Color get indigo_500 => Color(0xFF7B73C7);

  // Neutral Colors
  Color get white_A700 => Color(0xFFFFFFFF);
  Color get blue_gray_900 => Color(0xFF1A1A1A);
  Color get blue_gray_100 => Color(0xFF333333);
  Color get grey_700 => Color(0xFF333333);
  Color get grey_600 => Color(0xFF4A4A4A);
  Color get grey_500 => Color(0xFF666666);
  Color get grey_400 => Color(0xFF808080);
  Color get grey_300 => Color(0xFF999999);

  // Additional Colors
  Color get transparentCustom => Colors.transparent;
  Color get whiteCustom => Colors.white;
  Color get blackCustom => Color(0xFF000000);
  Color get greyCustom => Color(0xFF666666);

  // Color Shades - Each shade has its own dedicated constant
  Color get grey200 => Color(0xFF1A1A1A);
  Color get grey100 => Color(0xFF333333);

  // Background Colors
  Color get backgroundDark => Color(0xFF000000);
  Color get surfaceDark => Color(0xFF0A0A0A);
  Color get cardDark => Color(0xFF121212);
}
