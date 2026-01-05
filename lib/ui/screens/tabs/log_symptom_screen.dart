import 'package:flutter/material.dart';
import '../../../models/activity_item.dart';
// import '../widgets/selectable_grid.dart';
import '../activity_screen.dart';
import '../symptom_screen.dart';

class LogSymptomScreen extends StatelessWidget {
  const LogSymptomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final choices = [
      ActivityItem('Activity', Icons.directions_run),
      ActivityItem('Symptom', Icons.healing),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Log')),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16),
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        children: choices.map((item) {
          return GestureDetector(
            onTap: () {
              if (item.label == 'Activity') {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ActivityScreen()),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SymptomScreen()),
                );
              }
            },
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(item.icon, size: 40),
                  const SizedBox(height: 12),
                  Text(item.label, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
