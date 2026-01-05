import 'package:flutter/material.dart';
import '../../models/activity_item.dart';
import 'activity_card.dart';

class ActivityGrid extends StatelessWidget {
  final List<ActivityItem> activities;
  final Set<String> selectedActivities;
  final Function(String) onToggle;

  const ActivityGrid({
    super.key,
    required this.activities,
    required this.selectedActivities,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      padding: const EdgeInsets.all(12),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      children: activities.map((activity) {
        final isSelected = selectedActivities.contains(activity.label);

        return ActivityCard(
          activity: activity,
          isSelected: isSelected,
          onTap: () => onToggle(activity.label),
        );
      }).toList(),
    );
  }
}
