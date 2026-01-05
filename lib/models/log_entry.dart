import 'package:flutter/material.dart';

enum LogType { symptom, activity }

class LogEntry {
  final String title;
  final String time;
  final String subtitle;
  final String dateGroup; // e.g., "Today, Jan 5"
  final IconData icon;
  final Color color;
  final LogType type;

  LogEntry({
    required this.title,
    required this.time,
    required this.subtitle,
    required this.dateGroup,
    required this.icon,
    required this.color,
    required this.type,
  });
}