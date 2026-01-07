import 'package:flutter/material.dart';
import 'package:healme_dairy/models/logic_engine.dart';
import 'package:healme_dairy/ui/screens/analysis_screen.dart';
import '../../data/symptom_repository.dart';
import '../../models/log_entry.dart';
import 'package:intl/intl.dart';
import '../../models/log_item.dart';
import '../widgets/log_header.dart';
import '../widgets/save_button.dart';

class LogDetailScreen extends StatefulWidget {
  final LogItem symptom;
  final LogEntry? existingEntry;

  const LogDetailScreen({super.key, required this.symptom, this.existingEntry});

  @override
  State<LogDetailScreen> createState() => _LogDetailScreenState();
}

class _LogDetailScreenState extends State<LogDetailScreen> {
  List<LogEntry> latestSymptoms = [];
  late double _severity;
  late DateTime _selectedDate;
  late TextEditingController _notesController;

  /// Severity label based on slider value
  String get severityText {
    if (_severity < 3) return 'Mild';
    if (_severity < 7) return 'Moderate';
    return 'Severe';
  }

  Color severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return const Color.fromARGB(255, 213, 220, 88);
      case 'moderate':
        return const Color.fromARGB(255, 249, 170, 43);
      case 'severe':
        return const Color.fromARGB(255, 255, 67, 67);
      default:
        return const Color.fromARGB(255, 255, 175, 175);
    }
  }

  /// Date picker
  Future<void> _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2025),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      final now = DateTime.now();

      final updated = DateTime(
        picked.year,
        picked.month,
        picked.day,
        now.hour,
        now.minute,
        now.second,
      );
      setState(() => _selectedDate = updated);
    }
  }

  bool get _isFormValid {
    return true;
  }

  bool get isActivity => widget.symptom.type == Type.activity;

  @override
  void initState() {
    super.initState();
    _severity = widget.existingEntry?.severity?.toDouble() ?? 7.0;
    _selectedDate = widget.existingEntry?.date ?? DateTime.now();
    _notesController = TextEditingController(
      text: widget.existingEntry?.descriptions ?? "",
    );
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
        title: Text(
          widget.symptom.type == Type.symptom
              ? 'Log Symptom'
              : 'Log Activities',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),

            /// Symptom header
            Center(
              child: LogHeader(
                icon: widget.symptom.icon,
                label: widget.symptom.label,
                color: isActivity
                    ? Colors.green
                    : const Color.fromARGB(255, 231, 24, 48),
              ),
            ),
            if (widget.symptom.type == Type.symptom) ...[
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
                activeColor: severityColor(severityText),
                inactiveColor: Colors.grey.shade200,
                onChanged: (val) => setState(() => _severity = val),
              ),
            ],
            const SectionTitle('Time & Date'),
            CustomInputContainer(
              child: ListTile(
                title: Text(DateFormat('dd MMM yyyy').format(_selectedDate)),
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
              maxLines: 5,
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
          label: widget.symptom.type == Type.symptom
              ? 'Save and Analysis'
              : 'Save',
          onPressed: () async {
            final newLog = LogEntry(
              id: widget.existingEntry?.id,
              title: widget.symptom.label,
              severity: widget.symptom.type == Type.activity
                  ? null
                  : _severity.toInt(),
              date: _selectedDate,
              logItem: widget.symptom,
              descriptions: _notesController.text,
            );

            if (widget.existingEntry != null) {
              await SymptomRepository.updateLog(
                widget.existingEntry!.id,
                newLog,
              );
            } else {
              await SymptomRepository.addLog(newLog);
            }

            if (widget.symptom.type == Type.symptom) {
              final allLogs = SymptomRepository.getAll();

              final engine = LogicEngine(
                logs: allLogs,
                targetSymptom: widget.symptom,
              );
              final result = engine.analyzeSymptomPattern();

              await Navigator.push(
                // ignore: use_build_context_synchronously
                context,
                MaterialPageRoute(
                  builder: (_) => SymptomAnalysisScreen(
                    symptomLabel: widget.symptom.label,
                    analysisResult: result,
                  ),
                ),
              );
            }

            if (!mounted) return;
            Navigator.pop(context, newLog);
          },
        ),
      ),
    );
  }
}
