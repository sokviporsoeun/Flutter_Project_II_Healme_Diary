import 'package:healme_dairy/models/log_entry.dart';
import 'package:healme_dairy/models/log_item.dart';

class LogicEngine {
  final List<LogEntry> logs;
  final LogItem targetSymptom;

  LogicEngine({required this.logs, required this.targetSymptom});


// For this Logic 
  String analyxzeSymptom() {
    final symptomDates = logs
        .where(
          (log) =>
              log.logItem.type == Type.symptom &&
              log.logItem.label == targetSymptom.label,
        )
        .map((log) => "${log.date.year}-${log.date.month}-${log.date.day}")
        .toSet();

    //For this Condition is might be not happened because user save the symptom after analysis
    if (symptomDates.isEmpty) {
      return "Error: The saved log was not found in the analysis list.";
    }

    final Map<String, int> activityFrequency = {};
    for (final log in logs) {
      final logDateString =
          "${log.date.year}-${log.date.month}-${log.date.day}";
      if (log.logItem.type == Type.activity &&
          symptomDates.contains(logDateString)) {
        activityFrequency.update(
          log.logItem.label,
          (value) => value + 1,
          ifAbsent: () => 1,
        );
      }
    }
    if (activityFrequency.isEmpty) {
      return "No Data Recorded from this Symptom Found!";
    }
    final sorted = activityFrequency.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final top = sorted.first;
    return "When you had ${targetSymptom.label}, "
        "you most often  ${top.key} ${top.value} times. "
        "You probably cause this symptom becuase of this activity!";
  }
}
