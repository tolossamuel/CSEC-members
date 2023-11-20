import 'package:csec/theming/themes.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;
  IconData _icon = Icons.nightlight;

  ThemeData get themeData => _themeData;
  IconData get iconData => _icon;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  set iconData(IconData icon) {
    _icon = icon;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
      iconData = Icons.sunny;
    } else {
      themeData = lightMode;
      iconData = Icons.nightlight;
    }
  }
}
