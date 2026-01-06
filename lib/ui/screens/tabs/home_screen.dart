import 'package:flutter/material.dart';
import '../../widgets/header_card.dart';
import '../../widgets/section_header.dart';
import '../../widgets/symptom_card.dart';
import '../../../data/symptom_repository.dart';
import '../../../models/symptom_log.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SymptomLog> latestSymptoms = [];

  @override
  void initState() {
    super.initState();
    loadLatestSymptoms();
  }

  void loadLatestSymptoms() {
    setState(() {
      latestSymptoms = SymptomRepository.getLatest();
    });
  }

  Color severityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'mild':
        return const Color(0xFFE8ECA6);
      case 'moderate':
        return const Color(0xFFFFD89B);
      case 'severe':
        return const Color(0xFFFFCBCB);
      default:
        return Colors.grey;
    }
  }

  String timeAgo(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inHours < 1) return 'Just now';
    if (diff.inHours < 24) return '${diff.inHours} hours ago';
    return '${diff.inDays} days ago';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HeaderCard(
                date: '08 Jan, 2026',
                greeting: 'Good Morning, Ronan!',
                avatarUrl: 'https://i.pravatar.cc/150?img=12',
              ),

              const SizedBox(height: 32),

              SectionHeader(
                title: 'Latest Symptoms',
                onTap: () {},
              ),

              const SizedBox(height: 20),

              // Empty State
              if (latestSymptoms.isEmpty)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: Text(
                      'No symptoms logged yet',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )

              //data state
              else
                ...latestSymptoms.map((log) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SymptomCard(
                      symptom: log.symptom,
                      time: timeAgo(log.createdAt),
                      severity: log.severity,
                      color: severityColor(log.severity),
                    ),
                  );
                }),
            ],
          ),
        ),
      ),
    );
  }
}
