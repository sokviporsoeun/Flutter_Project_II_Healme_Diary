import 'package:flutter/material.dart';
import 'package:healme_dairy/ui/screens/log_detail_screen.dart';
import 'package:healme_dairy/ui/widgets/selectable_grid.dart';
import '../../models/log_item.dart';


class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final activities = [
    LogItem('Exercise', Icons.fitness_center, Type.activity),
    LogItem('Drink Water', Icons.local_drink, Type.activity),
    LogItem('Sleep', Icons.bedtime, Type.activity),
    LogItem('Use Phone', Icons.phone_android, Type.activity)
  ];

  final selected = <String>{};

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: const Text('Activity')),
      body: SelectableGrid(
        items: activities,
        selected: const {}, 
        onTap: (label) {
          final activity =
              activities.firstWhere((item) => item.label == label);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LogDetailScreen(symptom: activity),
            ),
          );
        },
      ),
    );
  }
}
