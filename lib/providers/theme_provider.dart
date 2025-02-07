import 'package:flutter/material.dart';
import 'package:sevenc_iteration_two/Themes.dart';

enum ThemeType { light, dark, custom } // Define three theme types

class ThemeProvider with ChangeNotifier {
  ThemeType _themeType = ThemeType.dark; // Default theme mode

  ThemeData get currentTheme {
    switch (_themeType) {
      case ThemeType.light:
        return AppTheme(TextTheme()).light();
      case ThemeType.dark:
        return AppTheme(TextTheme()).dark();
      case ThemeType.custom:
        return AppTheme(TextTheme()).custom();
      default:
        return AppTheme(TextTheme()).dark(); // Default to dark theme if none selected
    }
  }
    ThemeMode get themeMode {
    switch (_themeType) {
      case ThemeType.light:
        return ThemeMode.light;
      case ThemeType.dark:
        return ThemeMode.dark;
      case ThemeType.custom:
        return ThemeMode.light; // Custom themes use light/dark mode as base
    }
  }

  ThemeType get themeType => _themeType;

  void setTheme(ThemeType theme) {
    _themeType = theme;
    notifyListeners();
  }
}
