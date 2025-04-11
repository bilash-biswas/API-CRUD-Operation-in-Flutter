import 'package:flutter/foundation.dart';

class MyTheme extends ChangeNotifier {
  bool isDarkMode = false;
  bool get isDarkTheme => isDarkMode;
  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}