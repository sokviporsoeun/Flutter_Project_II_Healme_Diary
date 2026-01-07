import '../models/log_item.dart';
import '../models/log_entry.dart';
import 'sqlite.dart';

class SymptomRepository {
  static List<LogEntry> _logs = [];
  static Future<void> setLogs() async {
    _logs = await Sqlite.getEntries();
  }

  /// CREATE
  static Future<void> addLog(LogEntry log) async {
    _logs.add(log);
    await Sqlite.insertEntry(log);
  }

  /// READ all logs
  static List<LogEntry> getAll() {
    _logs.sort((a, b) => b.date.compareTo(a.date));
    return List.from(_logs);
  }

  static List<LogEntry> getTodayActivityLog() {
    final now = DateTime.now();
    final todayLogs = _logs
        .where(
          (log) =>
              log.logItem.type == Type.activity &&
              log.date.year == now.year &&
              log.date.month == now.month &&
              log.date.day == now.day,
        )
        .toList();
    todayLogs.sort((a, b) => b.date.compareTo(a.date));
    return todayLogs;
  }

  static List<LogEntry> getTodaySymptomLog() {
    final now = DateTime.now();
    final todayLogs = _logs
        .where(
          (log) =>
              log.logItem.type == Type.symptom &&
              log.date.year == now.year &&
              log.date.month == now.month &&
              log.date.day == now.day,
        )
        .toList();
    todayLogs.sort((a, b) => b.date.compareTo(a.date));
    return todayLogs;
  }

  static List<LogEntry> getAllSymptomLog() {
    final symptomLog = _logs
        .where((log) => log.logItem.type == Type.symptom)
        .toList();
    symptomLog.sort((a, b) => b.date.compareTo(a.date));
    return symptomLog.toList();
  }

  static LogEntry? getById(String id) {
    try {
      return _logs.firstWhere((log) => log.id == id);
    } catch (_) {
      return null;
    }
  }

  static Future<bool> updateLog(String id, LogEntry newLog) async {
    for (int i = 0; i < _logs.length; i++) {
      if (_logs[i].id == id) {
        _logs[i] = newLog;
        await Sqlite.updateEntry(newLog, id);
        return true;
      }
    }
    return false;
  }

  static Future<bool> deleteLog(String id) async {
    final initialLength = _logs.length;
    _logs.removeWhere((log) => log.id == id);
    await Sqlite.deleteEntry(id);
    return _logs.length < initialLength;
  }

  static bool hasData() => _logs.isNotEmpty;

  static void clearAll() => _logs.clear();
}
