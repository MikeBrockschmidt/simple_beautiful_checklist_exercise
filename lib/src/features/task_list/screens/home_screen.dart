import 'package:flutter/material.dart';
import 'package:simple_beautiful_checklist_exercise/data/database_repository.dart';
import 'package:simple_beautiful_checklist_exercise/src/features/statistics/screens/statistics_screen.dart';
import 'list_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    required this.repository,
    required this.isDarkMode,
    required this.onThemeToggle,
  });

  final DatabaseRepository repository;
  final bool isDarkMode;
  final void Function(bool) onThemeToggle;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedNavBarIndex = 0;
  late final List<Widget> _navBarWidgets;

  @override
  void initState() {
    super.initState();
    _navBarWidgets = [
      ListScreen(repository: widget.repository),
      StatisticsScreen(repository: widget.repository),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              const Icon(Icons.light_mode),
              Switch(
                value: widget.isDarkMode,
                onChanged: widget.onThemeToggle,
              ),
              const Icon(Icons.dark_mode),
              const SizedBox(width: 12),
            ],
          ),
        ],
      ),
      body: _navBarWidgets[_selectedNavBarIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Aufgaben',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Statistik',
          ),
        ],
        currentIndex: _selectedNavBarIndex,
        selectedItemColor: Colors.deepPurple[200],
        onTap: (int index) {
          setState(() {
            _selectedNavBarIndex = index;
          });
        },
      ),
    );
  }
}
