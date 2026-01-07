import 'package:flutter/material.dart';
import '../../models/log_item.dart';
import '../widgets/selectable_grid.dart';
import 'log_detail_screen.dart';

class SymptomScreen extends StatelessWidget {
  const SymptomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final symptoms =LogItem.allItems
    .where((i) => i.type == Type.symptom)
    .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Symptoms", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SelectableGrid(
        items: symptoms,
        selected: const {},
        onTap: (label) {
          final symptom = symptoms.firstWhere((item) => item.label == label);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => LogDetailScreen(symptom: symptom),
            ),
          );
        },
      ),
    );
  }
}
