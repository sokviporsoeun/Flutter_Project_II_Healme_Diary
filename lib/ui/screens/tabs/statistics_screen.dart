
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../models/log_entry.dart';
import '../../widgets/app_line_chart.dart';

class StatisticsScreen extends StatelessWidget {
  final List<LogEntry> userLogs; 

  const StatisticsScreen({super.key, required this.userLogs});

  @override
  Widget build(BuildContext context) {
    // Filter data for charts
    final symptomSpots = _generateSymptomSpots();
    final activitySpots = _generateActivitySpots();

    final bool hasData = symptomSpots.isNotEmpty || activitySpots.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Statistics"),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: !hasData 
          ? _buildEmptyState() 
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (symptomSpots.isNotEmpty)
                    AppLineChart(
                      title: "Symptom Severity",
                      points: symptomSpots,
                      barColor: Colors.redAccent,
                    ),
                  const SizedBox(height: 40),
                  if (activitySpots.isNotEmpty)
                    AppLineChart(
                      title: "Activity Trends",
                      points: activitySpots,
                      barColor: Colors.green,
                    ),
                ],
              ),
            ),
      ),
    );
  }

  // Map LogEntries to Chart Data Points (X = Time/Index, Y = Value)
  List<FlSpot> _generateSymptomSpots() {
    final symptoms = userLogs.where((l) => l.type == LogType.symptom).toList();
    return List.generate(symptoms.length, (index) {

      // For this example, we assume subtitle contains "Level: X/10"
           
      return FlSpot(index.toDouble(), 7.0); // Dummy Y value
    });
  }

  List<FlSpot> _generateActivitySpots() {
    final activities = userLogs.where((l) => l.type == LogType.activity).toList();
    return List.generate(activities.length, (index) {
      return FlSpot(index.toDouble(), 5.0); // Dummy Y value
    });
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Statistics will appear here 📊",
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
