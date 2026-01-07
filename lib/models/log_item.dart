import 'package:flutter/material.dart';
enum Type { 
  symptom(color: Colors.red, icon: Icons.healing),
  activity(color: Colors.green, icon: Icons.directions_run);
  final Color color;
  final IconData icon;
  const Type({required this.color, required this.icon});
}

class LogItem {
  final String label;
  final IconData icon;
  final Type type;
  LogItem(this.label, this.icon, this.type);


  static List<LogItem> allItems = [
    LogItem('Exercise', Icons.fitness_center, Type.activity),
    LogItem('Poor Sleep', Icons.bedtime, Type.activity),
    LogItem('Use Phone', Icons.phone_android, Type.activity),
    LogItem('Coffee', Icons.local_cafe, Type.activity),
    LogItem('Skip Meal', Icons.fastfood, Type.activity),
    LogItem('Stress', Icons.work, Type.activity),
    LogItem('Alcohol', Icons.local_bar, Type.activity),
    LogItem('Screen Time', Icons.computer, Type.activity),
    LogItem('Late Night', Icons.nights_stay, Type.activity),
    LogItem('Junk Food', Icons.lunch_dining, Type.activity),
    LogItem('Long Sitting', Icons.chair, Type.activity),

    LogItem("Headache", Icons.psychology, Type.symptom),
    LogItem('Stomachache', Icons.sick, Type.symptom),
    LogItem('Fatigue', Icons.battery_alert, Type.symptom),
    LogItem('Body Pain', Icons.accessibility_new, Type.symptom),
    LogItem('Nausea', Icons.sentiment_dissatisfied, Type.symptom),
    LogItem('Dizziness', Icons.explore, Type.symptom),
  ];

}




