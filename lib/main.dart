import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/shared_preferences_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final repository = SharedPreferencesRepository();
  final themeMode = await loadSavedThemeMode();
  runApp(App(repository: repository, initialThemeMode: themeMode));
}

Future<ThemeMode> loadSavedThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final mode = prefs.getString('themeMode');
  switch (mode) {
    case 'light':
      return ThemeMode.light;
    case 'dark':
      return ThemeMode.dark;
    default:
      return ThemeMode.system;
  }
}
