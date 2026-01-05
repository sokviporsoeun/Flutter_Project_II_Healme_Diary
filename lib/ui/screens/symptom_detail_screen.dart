import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/activity_item.dart';
import '../widgets/symptom_detail_card.dart';
import '../widgets/save_button.dart';

class SymptomDetailScreen extends StatefulWidget {
  final ActivityItem symptom;

  const SymptomDetailScreen({
    super.key,
    required this.symptom,
  });

  @override
  State<SymptomDetailScreen> createState() => _SymptomDetailScreenState();
}

class _SymptomDetailScreenState extends State<SymptomDetailScreen> {
  double _severity = 7;
  DateTime _selectedDate = DateTime.now();
  final TextEditingController _notesController = TextEditingController();

  /// Severity label based on slider value
  String get severityText {
    if (_severity < 3) return 'Mild';
    if (_severity < 7) return 'Moderate';
    return 'Severe';
  }

  /// Date picker
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() => _selectedDate = picked);
    }
  }

  bool get _isFormValid => _notesController.text.trim().isNotEmpty;

  @override
  void initState() {
    super.initState();
    _notesController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.blue),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Log Symptom',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            /// Symptom header
            Center(
              child: SymptomHeader(
                icon: widget.symptom.icon,
                label: widget.symptom.label,
              ),
            ),

            const SectionTitle('Severity'),
            Center(
              child: Column(
                children: [
                  Text(
                    _severity.toInt().toString(),
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    severityText,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),

            Slider(
              value: _severity,
              min: 0,
              max: 10,
              divisions: 10,
              activeColor: Colors.orange,
              inactiveColor: Colors.grey.shade200,
              onChanged: (val) => setState(() => _severity = val),
            ),

            const SectionTitle('Time & Date'),
            CustomInputContainer(
              child: ListTile(
                title: Text(
                  DateFormat('dd MMM yyyy').format(_selectedDate),
                ),
                trailing: const Icon(
                  Icons.calendar_today,
                  color: Colors.blue,
                  size: 20,
                ),
                onTap: _pickDate,
              ),
            ),

            const SectionTitle('Notes (Optional)'),
            TextField(
              controller: _notesController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: 'Add details...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.shade300),
                ),
              ),
            ),

            const SizedBox(height: 120),
          ],
        ),
      ),

      /// Save button
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: SaveButton(
          enabled: _isFormValid,
          onPressed: () {
            final logData = {
              'symptom': widget.symptom.label,
              'severity': _severity.toInt(),
              'date': _selectedDate.toIso8601String(),
              'notes': _notesController.text,
            };

            debugPrint('Saving Log: $logData');
            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
