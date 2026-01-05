import 'package:flutter/material.dart';
import '../../models/activity_item.dart';
import '../widgets/activity_card.dart';
import '../widgets/save_button.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final activities = [
    ActivityItem('Exercise', Icons.fitness_center),
    ActivityItem('Drink Water', Icons.local_drink),
    ActivityItem('Sleep', Icons.bedtime),
    ActivityItem('Use Phone', Icons.phone_android),
  ];

  final selected = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activities')),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: activities.length,
              itemBuilder: (context, index) {
                final item = activities[index];
                final isSelected = selected.contains(item.label);

                return ActivityCard(
                  activity: item,
                  isSelected: isSelected,
                  onTap: () {
                    setState(() {
                      isSelected
                          ? selected.remove(item.label)
                          : selected.add(item.label);
                    });
                  },
                );
              },
            ),
          ),

          // Reusable Save Button
          SaveButton(
            enabled: selected.isNotEmpty,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
