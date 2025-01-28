import 'package:flutter/material.dart';

void main() {
  runApp(const HomeworkScreen());
}

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  // List of homework tasks
  List<Map<String, dynamic>> homeworkList = [
    {
      "subject": "English",
      "task": "Learn Chapter 5: Letter Writing",
      "time": "Due Today"
    },
    {
      "subject": "Mathematics",
      "task": "Exercise: Trigonometry formulas",
      "time": "Due Tomorrow"
    },
    {"subject": "Science", "task": "Complete lab report", "time": "Due Friday"},
    {
      "subject": "Social Studies",
      "task": "Revise for History Test",
      "time": "Due Monday"
    },
  ];
  final List<Color> colors = [
    Colors.blue.shade100,
    Colors.pink.shade100,
    Colors.green.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          backgroundColor: Colors.deepPurple,
          elevation: 0,
          title: const Text(
            'Homework',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              // Add menu functionality here
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          // color: Color(0xFFF2F2F2),
          // color: colors[index % colors.length],

          child: Column(
            children: [
              // Notice Board Section
              Container(
                // color: Colors.deepPurple,
                padding: const EdgeInsets.all(16),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Notice Board",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Upcoming Test on Monday",
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // Homework List Section
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: homeworkList.length,
                  itemBuilder: (context, index) {
                    return HomeworkCard(
                      color: colors[index % colors.length],
                      subject: homeworkList[index]["subject"],
                      task: homeworkList[index]["task"],
                      time: homeworkList[index]["time"],
                      onDelete: () {
                        setState(() {
                          homeworkList
                              .removeAt(index); // Remove task dynamically
                        });
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeworkCard extends StatelessWidget {
  final String subject;
  final String task;
  final String time;
  final Color color;
  final VoidCallback onDelete;

  const HomeworkCard({super.key, 
    required this.subject,
    required this.task,
    required this.time,
    required this.color,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Colors.white,
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subject,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            task,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red, size: 20),
                    onPressed: onDelete, // Delete functionality
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey,
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
