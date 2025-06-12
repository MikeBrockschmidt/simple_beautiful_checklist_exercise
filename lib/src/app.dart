import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/splash/splash_screen.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/task_list/screens/home_screen.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.repository,
    required this.initialThemeMode,
  });

  final DatabaseRepository repository;
  final ThemeMode initialThemeMode;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late ThemeMode _themeMode;

  @override
  void initState() {
    super.initState();
    _themeMode = widget.initialThemeMode;
  }

  void _toggleTheme(bool isDarkMode) async {
    setState(() {
      _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    });
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('themeMode', isDarkMode ? 'dark' : 'light');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        textTheme: GoogleFonts.latoTextTheme(),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        textTheme: GoogleFonts.latoTextTheme(
          ThemeData(brightness: Brightness.dark).textTheme,
        ),
      ),
      themeMode: _themeMode,
      title: 'Checklisten App',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => HomeScreen(
          repository: widget.repository,
          isDarkMode: _themeMode == ThemeMode.dark,
          onThemeToggle: _toggleTheme,
        ),
      },
    );
  }
}
