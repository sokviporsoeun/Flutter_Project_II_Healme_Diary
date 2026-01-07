
import 'package:uuid/uuid.dart';
import 'log_item.dart';

class LogEntry {
  final String id;
  final String title;
  final String descriptions;
  final DateTime date;
  final LogItem logItem;
  final int? severity;

  LogEntry({
    String? id,
    required this.title,
    this.severity,
    required this.date,
    required this.logItem,
    this.descriptions = "",
  }) : id = id ?? const Uuid().v4();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'descriptions': descriptions,
      'severity': severity == null ? 0 : severity,
      'logItem': logItem.label,
      'date': date.toIso8601String(),
    };
  }

  static LogEntry fromMap(Map<String, dynamic> map) {
    return LogEntry(
      id: map['id'],
      title: map['title'],
      descriptions: map['descriptions'],
      severity: map["severity"] == 0 ? null : map["severity"].round().toInt(),
      logItem: LogItem.allItems.firstWhere((li) => li.label == map['logItem']),
      date: DateTime.parse(map['date']),
    );
  }

  
}
