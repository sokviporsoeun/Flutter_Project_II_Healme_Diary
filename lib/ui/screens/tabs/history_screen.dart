import 'package:flutter/material.dart';
import '../../../models/log_entry.dart';
import '../../widgets/history_list_widgets.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _selectedFilter = 'All';
  final List<LogEntry> _userLogs = []; // Empty by default

  @override
  Widget build(BuildContext context) {
    // Filter Logic
    List<LogEntry> filteredLogs = _userLogs.where((log) {
      if (_selectedFilter == 'Symptoms') return log.type == LogType.symptom;
      if (_selectedFilter == 'Activities') return log.type == LogType.activity;
      return true;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FE),
      appBar: AppBar(
        title: const Text("History Log", 
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filter Chips
          _buildFilterBar(),
          
          const SizedBox(height: 20),
          
          // Conditional Content using Reusable Widgets
          Expanded(
            child: filteredLogs.isEmpty 
              ? const EmptyHistoryState() 
              : HistoryTimelineList(logs: filteredLogs),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar() {
    return Row(
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
            showCheckmark: false,
            labelStyle: TextStyle(
              color: isSelected ? Colors.blue.shade800 : Colors.black,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
    );
  }
}