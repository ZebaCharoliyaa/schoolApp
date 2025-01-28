import 'package:flutter/material.dart';
import 'package:school/question.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ExaminationScreen(),
    );
  }
}

class ExaminationScreen extends StatelessWidget {
  const ExaminationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Examination',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Examination List',
              style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: const [
                  ExamCard(
                    title: 'Science Basic Assessment Test',
                    duration: 'Duration: 30 Min',
                    buttonText: 'Start Test',
                    buttonColor: Colors.red,
                    buttonIcon: Icons.play_arrow,
                  ),
                  ExamCard(
                    title: 'General Knowledge Level IV',
                    duration: 'Duration: 30 Min',
                    score: 'Score: 40/200',
                    buttonText: 'Completed',
                    buttonColor: Colors.green,
                  ),
                  ExamCard(
                    title: 'Math Super 20 Exam',
                    duration: 'Duration: 30 Min',
                    buttonText: 'Start Test',
                    buttonColor: Colors.red,
                    buttonIcon: Icons.play_arrow,
                  ),
                  ExamCard(
                    title: 'General Knowledge Level III',
                    duration: 'Duration: 30 Min',
                    score: 'Score: 40/200',
                    buttonText: 'Completed',
                    buttonColor: Colors.green,
                  ),
                  ExamCard(
                    title: 'English Basic Assessment Test',
                    duration: 'Duration: 30 Min',
                    buttonText: 'Start Test',
                    buttonColor: Colors.red,
                    buttonIcon: Icons.play_arrow,
                  ),
                  ExamCard(
                    title: 'General Knowledge Level II',
                    duration: 'Duration: 30 Min',
                    score: 'Score: 40/200',
                    buttonText: 'Completed',
                    buttonColor: Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamCard extends StatelessWidget {
  final String title;
  final String duration;
  final String? score;
  final String buttonText;
  final Color buttonColor;
  final IconData? buttonIcon;

  const ExamCard({super.key, 
    required this.title,
    required this.duration,
    this.score,
    required this.buttonText,
    required this.buttonColor,
    this.buttonIcon,
  });
  @override
  Widget build(BuildContext context) {
    return Card(
      color: score != null ? Colors.green[100] : Colors.pink[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  duration,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
            if (score != null) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.check_circle, size: 16, color: Colors.green),
                  const SizedBox(width: 4),
                  Text(
                    score!,
                    style: const TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ],
            const SizedBox(height: 8),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ExamScreen(),
                    ));
              },
              icon: buttonIcon != null
                  ? Icon(
                      buttonIcon,
                      size: 16,
                      color: Colors.white,
                    )
                  : const SizedBox.shrink(),
              label: Text(
                buttonText,
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
