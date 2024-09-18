import 'package:flutter/material.dart';
import 'package:trabalho/themes/light_mode.dart';
import 'package:trabalho/themes/dark_mode.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData; // Corrigido: agora o valor é atribuído corretamente
    notifyListeners(); // Notifica os ouvintes da mudança
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
