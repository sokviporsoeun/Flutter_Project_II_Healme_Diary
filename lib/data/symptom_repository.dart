import '../models/symptom_log.dart';

class SymptomRepository {
  static final List<SymptomLog> _logs = [];

  static void addSymptom(SymptomLog log) {
    _logs.add(log);
  }

  static List<SymptomLog> getLatest({int limit = 3}) {
    _logs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return _logs.take(limit).toList();
  }

  static bool hasData() => _logs.isNotEmpty;
}
