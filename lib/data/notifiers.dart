import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> selectedPageNotifier = ValueNotifier(0);
ValueNotifier<bool> isDarkModeNotifier = ValueNotifier(false);

const String _darkModePrefKey = 'is_dark_mode';

Future<void> loadAppSettings() async {
  final prefs = await SharedPreferences.getInstance();
  isDarkModeNotifier.value = prefs.getBool(_darkModePrefKey) ?? false;
}

Future<void> setDarkMode(bool isDarkMode) async {
  isDarkModeNotifier.value = isDarkMode;
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(_darkModePrefKey, isDarkMode);
}
