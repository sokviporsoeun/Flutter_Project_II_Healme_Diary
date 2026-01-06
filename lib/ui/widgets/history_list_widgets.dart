import 'package:flutter/material.dart';
import '../../models/log_entry.dart';
import 'history_card.dart';

/// Shown when there are no logs to display
class EmptyHistoryState extends StatelessWidget {
  const EmptyHistoryState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_toggle_off, size: 80, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            "No logs recorded yet",
            style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
          ),
        ],
      ),
    );
  }
}

/// The actual scrollable list with the vertical timeline line
class HistoryTimelineList extends StatelessWidget {
  final List<LogEntry> logs;

  const HistoryTimelineList({super.key, required this.logs});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The Vertical Timeline Line
        Positioned(
          left: 30,
          top: 0,
          bottom: 0,
          child: Container(width: 2, color: Colors.grey.shade300),
        ),
        ListView.builder(
          itemCount: logs.length,
          itemBuilder: (context, index) {
            final log = logs[index];
            // Logic to show the date header only when the date changes
            bool showDate = index == 0 || logs[index - 1].dateGroup != log.dateGroup;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (showDate)
                  Padding(
                    padding: const EdgeInsets.only(left: 20, bottom: 15, top: 10),
                    child: Text(
                      log.dateGroup,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                HistoryCard(
                  title: log.title,
                  time: log.time,
                  subtitle: log.subtitle,
                  icon: log.icon,
                  accentColor: log.color,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}