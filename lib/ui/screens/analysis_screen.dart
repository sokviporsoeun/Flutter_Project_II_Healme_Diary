import 'package:flutter/material.dart';
import 'package:healme_dairy/ui/widgets/save_button.dart';

class SymptomAnalysisScreen extends StatelessWidget {
  final String symptomLabel;
  final String analysisResult;

  const SymptomAnalysisScreen({
    super.key,
    required this.symptomLabel,
    required this.analysisResult,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Analysis: $symptomLabel",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            Text(analysisResult, style: TextStyle(fontSize: 16)),
            const Spacer(),
            Center(
              child: SaveButton(
                onPressed: () => Navigator.pop(context),
                label: 'Close',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
