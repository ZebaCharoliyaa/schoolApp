import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';
import 'package:school/services/auth_service.dart';

class HomeworkScreen extends StatefulWidget {
  @override
  _HomeworkScreenState createState() => _HomeworkScreenState();
}

class _HomeworkScreenState extends State<HomeworkScreen> {
  String formatDueDate(dynamic dueDate) {
    if (dueDate is String) {
      return dueDate; // Already formatted
    } else if (dueDate is int) {
      DateTime date = DateTime.fromMillisecondsSinceEpoch(dueDate);
      return "${date.year}-${date.month}-${date.day}"; // Formats to YYYY-MM-DD
    } else {
      return "No Due Date";
    }
  }

  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> homeworkList = [];
  bool isLoading = true;
  bool hasError = false;
  String? studentStandardId;

  @override
  void initState() {
    super.initState();
    fetchStandardIdAndHomework();
  }

  /// ✅ Fetches `standardId` from SharedPreferences and retrieves homework
  Future<void> fetchStandardIdAndHomework() async {
    try {
      studentStandardId = await AuthService.getStudentStandardId();

      if (studentStandardId == null) {
        print("❌ Error: studentStandardId is null.");
        setState(() {
          isLoading = false;
          hasError = true;
        });
        return;
      }

      print("📌 Standard ID: $studentStandardId");

      List<Map<String, dynamic>>? fetchedHomework =
          await apiService.fetchHomework(studentStandardId!);

      print("📝 Homework Data: $fetchedHomework");

      setState(() {
        homeworkList = fetchedHomework ?? []; // Ensure it's never null
        isLoading = false;
        hasError = homeworkList.isEmpty;
      });
    } catch (e) {
      print("❌ Error fetching homework: $e");
      setState(() {
        isLoading = false;
        hasError = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text('Home Work', style: TextStyle(color: Colors.white)),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 50),
                      SizedBox(height: 10),
                      Text(
                        "❌ Failed to load homework. Try again.",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: fetchStandardIdAndHomework,
                        child: Text("Retry"),
                      ),
                    ],
                  ),
                )
              : homeworkList.isEmpty
                  ? Center(child: Text("No homework available."))
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: homeworkList.length,
                      itemBuilder: (context, index) {
                        final notice = homeworkList[index];
                        final List<Color?> noticeColors = [
                          Colors.blue[100],
                          Colors.pink[100],
                          Colors.green[100]
                        ];
                        final Color? noticeColor =
                            noticeColors[index % noticeColors.length];

                        return HomeworkCard(
                          color: noticeColor,
                          subject: notice['subject'] ?? "No Subject",
                          title: notice['title'] ?? "No Title",
                          description:
                              notice['description'] ?? "No Description",
                          time: formatDueDate(notice['dueDate']),
                        );
                      },
                    ),
    );
  }
}

// ✅ Updated HomeworkCard to Allow Nullable Color
class HomeworkCard extends StatelessWidget {
  final String subject;
  final String title;
  final String description;
  final String time;
  final Color? color;

  const HomeworkCard({
    super.key,
    required this.subject,
    required this.description,
    required this.time,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color ?? Colors.white, // Default color if null
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
          // ✅ Subject Name
          Text(
            "📚  $subject",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Title: $title',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // ✅ Homework Description
          Text(
            'Description: $description',
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          // ✅ Due Date
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "📅 Due Date: $time",
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
