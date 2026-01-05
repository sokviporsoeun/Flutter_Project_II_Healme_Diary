import 'package:flutter/material.dart';
import '../../models/activity_item.dart';
import '../widgets/selectable_grid.dart';
import 'symptom_detail_screen.dart';

class SymptomScreen extends StatelessWidget {
  const SymptomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final symptoms = [
      ActivityItem('Headache', Icons.psychology),
      ActivityItem('Stomachache', Icons.sick),
      ActivityItem('Fatigue', Icons.battery_alert),
      ActivityItem('Body Pain', Icons.accessibility_new),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Symptoms')),
      body: SelectableGrid(
        items: symptoms,
        selected: const {}, // ❌ no selection needed here
        onTap: (label) {
          final symptom =
              symptoms.firstWhere((item) => item.label == label);

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => SymptomDetailScreen(symptom: symptom),
            ),
          );
        },
      ),
    );
  }
}
