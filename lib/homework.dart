// import 'package:flutter/material.dart';

// void main() {
//   runApp(const HomeworkScreen());
// }

// class HomeworkScreen extends StatefulWidget {
//   const HomeworkScreen({super.key});

//   @override
//   _HomeworkScreenState createState() => _HomeworkScreenState();
// }

// class _HomeworkScreenState extends State<HomeworkScreen> {
//   // List of homework tasks
//   List<Map<String, dynamic>> homeworkList = [
//     {
//       "subject": "English",
//       "task": "Learn Chapter 5: Letter Writing",
//       "time": "Due Today"
//     },
//     {
//       "subject": "Mathematics",
//       "task": "Exercise: Trigonometry formulas",
//       "time": "Due Tomorrow"
//     },
//     {"subject": "Science", "task": "Complete lab report", "time": "Due Friday"},
//     {
//       "subject": "Social Studies",
//       "task": "Revise for History Test",
//       "time": "Due Monday"
//     },
//   ];
//   final List<Color> colors = [
//     Colors.blue.shade100,
//     Colors.pink.shade100,
//     Colors.green.shade100,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           shape: const RoundedRectangleBorder(
//             borderRadius: BorderRadius.vertical(
//               bottom: Radius.circular(20),
//             ),
//           ),
//           backgroundColor: Colors.deepPurple,
//           elevation: 0,
//           title: const Text(
//             'Homework',
//             style: TextStyle(
//                 fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.white,
//             ),
//             onPressed: () {
//               // Add menu functionality here
//               Navigator.pop(context);
//             },
//           ),
//         ),
//         body: Container(
//           // color: Color(0xFFF2F2F2),
//           // color: colors[index % colors.length],

//           child: Column(
//             children: [
//               // Homework List Section
//               Expanded(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.all(16),
//                   itemCount: homeworkList.length,
//                   itemBuilder: (context, index) {
//                     return HomeworkCard(
//                       color: colors[index % colors.length],
//                       subject: homeworkList[index]["subject"],
//                       task: homeworkList[index]["task"],
//                       time: homeworkList[index]["time"],
//                       onDelete: () {
//                         setState(() {
//                           homeworkList
//                               .removeAt(index); // Remove task dynamically
//                         });
//                       },
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class HomeworkCard extends StatelessWidget {
//   final String subject;
//   final String task;
//   final String time;
//   final Color color;
//   final VoidCallback onDelete;

//   const HomeworkCard({
//     super.key,
//     required this.subject,
//     required this.task,
//     required this.time,
//     required this.color,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 12),
//       padding: const EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         // color: Colors.white,
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.grey.withOpacity(0.2),
//             blurRadius: 6,
//             offset: const Offset(0, 3),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             subject,
//             style: const TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.bold,
//               color: Colors.black,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Text(
//             task,
//             style: const TextStyle(
//               fontSize: 14,
//               color: Colors.black87,
//             ),
//           ),
//           const SizedBox(height: 8),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 time,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   color: Colors.grey,
//                 ),
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     icon: const Icon(Icons.delete, color: Colors.red, size: 20),
//                     onPressed: onDelete, // Delete functionality
//                   ),
//                   const Icon(
//                     Icons.arrow_forward_ios,
//                     size: 14,
//                     color: Colors.grey,
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';

class HomeworkScreen extends StatefulWidget {
  const HomeworkScreen({super.key});

  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> homeworkList = [];
  bool isLoading = true;
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    fetchHomework(); // ✅ Fetch homework from API when screen loads
  }

  Future<void> fetchHomework() async {
    try {
      List<Map<String, dynamic>> fetchedHomework =
          await apiService.fetchHomework('Class 1');

      if (mounted) {
        setState(() {
          homeworkList = fetchedHomework;
          isLoading = false;
          hasError = false;
        });
      }
    } catch (e) {
      print("❌ Error fetching homework: $e");
      if (mounted) {
        setState(() {
          isLoading = false;
          hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
          AppBar(title: Text("Homework"), backgroundColor: Colors.deepPurple),
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // ✅ Show loading spinner
          : hasError
              ? Center(child: Text("❌ Failed to load homework. Try again."))
              : homeworkList.isEmpty
                  ? Center(child: Text("📚 No homework available."))
                  : ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: homeworkList.length,
                      itemBuilder: (context, index) {
                        return HomeworkCard(
                          subject: homeworkList[index]['subject'],
                          task: homeworkList[index]['description'],
                          time: homeworkList[index]['dueDate'],
                        );
                      },
                    ),
    );
  }
}

// ✅ Reusable Homework Card UI
class HomeworkCard extends StatelessWidget {
  final String subject;
  final String task;
  final String time;

  const HomeworkCard(
      {super.key,
      required this.subject,
      required this.task,
      required this.time});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(Icons.book, color: Colors.deepPurple),
        title: Text(subject, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(task),
        trailing: Text(time, style: TextStyle(color: Colors.grey)),
      ),
    );
  }
}
