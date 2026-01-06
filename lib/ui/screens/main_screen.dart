import 'package:flutter/material.dart';
import 'tabs/home_screen.dart';
import 'tabs/log_symptom_screen.dart';
import 'tabs/statistics_screen.dart';
import 'tabs/history_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _index = 0;

  final List<Widget> screens = [
    const HomeScreen(),
    const LogSymptomScreen(),
    const StatisticsScreen(userLogs: []), 
    const HistoryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_index],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _index,
        onTap: (newIndex) {
          setState(() {
            _index = newIndex;
          });
        },
      ),
    );
  }
}
