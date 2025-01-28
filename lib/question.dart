import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExamScreen(),
    );
  }
}

class ExamScreen extends StatefulWidget {
  const ExamScreen({super.key});

  @override
  _ExamScreenState createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> {
  // Track selected answers for each question
  Map<int, String> selectedAnswers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: const Text(
            "General Knowledge Test",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Exam Code: 121",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  QuestionWidget(
                    questionNumber: 1,
                    questionText:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at risus commodo.",
                    options: const [
                      "Suspendisse egestas tellus",
                      "Morbi et diam vulputate",
                      "Proin et tellus consectetur",
                      "In vestibulum tortor in magna pharetra",
                    ],
                    selectedAnswer: selectedAnswers[1],
                    onAnswerSelected: (answer) {
                      setState(() {
                        selectedAnswers[1] = answer;
                      });
                    },
                  ),
                  QuestionWidget(
                    questionNumber: 2,
                    questionText:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at risus commodo.",
                    options: const [
                      "Suspendisse egestas tellus",
                      "Morbi et diam vulputate",
                      "Proin et tellus consectetur",
                      "In vestibulum tortor in magna pharetra",
                    ],
                    selectedAnswer: selectedAnswers[2],
                    onAnswerSelected: (answer) {
                      setState(() {
                        selectedAnswers[2] = answer;
                      });
                    },
                  ),
                  QuestionWidget(
                    questionNumber: 3,
                    questionText:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at risus commodo.",
                    options: const [
                      "Suspendisse egestas tellus",
                      "Morbi et diam vulputate",
                      "Proin et tellus consectetur",
                      "In vestibulum tortor in magna pharetra",
                    ],
                    selectedAnswer: selectedAnswers[3],
                    onAnswerSelected: (answer) {
                      setState(() {
                        selectedAnswers[3] = answer;
                      });
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submission logic
                  print("Selected Answers: $selectedAnswers");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuestionWidget extends StatelessWidget {
  final int questionNumber;
  final String questionText;
  final List<String> options;
  final String? selectedAnswer;
  final ValueChanged<String> onAnswerSelected;

  const QuestionWidget({
    super.key,
    required this.questionNumber,
    required this.questionText,
    required this.options,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question $questionNumber (2 Marks)",
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Background color for the question
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              questionText,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
          const SizedBox(height: 8),
          Column(
            children: options.map((option) {
              return RadioListTile<String>(
                value: option,
                groupValue: selectedAnswer,
                onChanged: (value) {
                  if (value != null) onAnswerSelected(value);
                },
                title: Text(option),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
