import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExamScreen(),
    );
  }
}

class ExamScreen extends StatefulWidget {
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: Text(
            "General Knowledge Test",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          backgroundColor: Colors.deepPurple,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ))),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Exam Code: 121",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  QuestionWidget(
                    questionNumber: 1,
                    questionText:
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin at risus commodo.",
                    options: [
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
                    options: [
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
                    options: [
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
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Handle submission logic
                  print("Selected Answers: $selectedAnswers");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
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
    Key? key,
    required this.questionNumber,
    required this.questionText,
    required this.options,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question $questionNumber (2 Marks)",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey[200], // Background color for the question
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              questionText,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
          ),
          SizedBox(height: 8),
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
