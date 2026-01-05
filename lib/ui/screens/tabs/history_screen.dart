import 'package:flutter/material.dart';
import '../../../models/log_entry.dart';
import '../../widgets/history_card.dart';
// import '../../widgets/bottom_nav_bar.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';

  // Sample Data
  final List<LogEntry> allLogs = [
    LogEntry(
      title: "Severe Headache",
      time: "10:30 AM",
      subtitle: "Pain Level: 8/10. Took Tylenol.",
      dateGroup: "Today, Jan 5",
      icon: Icons.psychology,
      color: Colors.red,
      type: LogType.symptom,
    ),
    LogEntry(
      title: "Morning Jog",
      time: "7:00 AM",
      subtitle: "Distance: 5km, Time: 30m. Felt energized.",
      dateGroup: "Today, Jan 5",
      icon: Icons.directions_run,
      color: Colors.green,
      type: LogType.activity,
    ),
    LogEntry(
      title: "Nausea",
      time: "9:15 PM",
      subtitle: "Mild discomfort after dinner.",
      dateGroup: "Yesterday, Jan 4",
      icon: Icons.medication_liquid, // Replace with your stomach icon
      color: Colors.deepPurple,
      type: LogType.symptom,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // Filter logic
    List<LogEntry> filteredLogs = allLogs.where((log) {
      if (_selectedFilter == 'Symptoms') return log.type == LogType.symptom;
      if (_selectedFilter == 'Activities') return log.type == LogType.activity;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text("History Log", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Chips
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['All', 'Symptoms', 'Activities'].map((filter) {
              bool isSelected = _selectedFilter == filter;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: ChoiceChip(
                  label: Text(filter),
                  selected: isSelected,
                  onSelected: (val) => setState(() => _selectedFilter = filter),
                  selectedColor: Colors.blue.shade100,
                  backgroundColor: Colors.grey.shade200,
                  labelStyle: TextStyle(color: isSelected ? Colors.blue.shade800 : Colors.black),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 20),
          // History List with Timeline line
          Expanded(
            child: Stack(
              children: [
                // The Vertical Timeline Line
                Positioned(
                  left: 30,
                  top: 0,
                  bottom: 0,
                  child: Container(width: 2, color: Colors.grey.shade300),
                ),
                ListView.builder(
                  itemCount: filteredLogs.length,
                  itemBuilder: (context, index) {
                    final log = filteredLogs[index];
                    bool showDate = index == 0 || filteredLogs[index - 1].dateGroup != log.dateGroup;

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
            ),
          ),
        ],
      ),
    );
  }
}