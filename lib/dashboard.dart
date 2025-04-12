import 'package:flutter/material.dart';
import 'package:school/accountselection.dart';
import 'package:school/attendance.dart';
import 'package:school/homework.dart';
import 'package:school/naticeBoard.dart';
import 'package:school/profile.dart';
import 'package:school/report.dart';
import 'package:school/services/api_services.dart';
import 'package:school/services/auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> notices = [];
  List<Map<String, dynamic>> homeworkList = [];
  bool isLoadingNotices = true;
  bool isLoadingHomework = true;

  @override
  void initState() {
    super.initState();
    fetchNotices();
    fetchHomework();
  }

  Future<void> fetchNotices() async {
    try {
      List<Map<String, dynamic>> latestNotices = await apiService.getNotices();
      latestNotices.sort((a, b) =>
          DateTime.parse(b['date']).compareTo(DateTime.parse(a['date'])));
      if (mounted) {
        setState(() {
          notices = latestNotices.take(3).toList();
          isLoadingNotices = false;
        });
      }
    } catch (e) {
      print("Error fetching notices: $e");
      if (mounted) setState(() => isLoadingNotices = false);
    }
  }

  Future<void> fetchHomework() async {
    try {
      String? studentStandardId = await AuthService.getStudentStandardId();
      if (studentStandardId == null) {
        print("Error: studentStandardId is null.");
        return;
      }
      List<Map<String, dynamic>> fetchedHomework =
          await apiService.fetchHomework(studentStandardId);
      if (mounted) {
        setState(() {
          homeworkList = fetchedHomework.take(3).toList();
          isLoadingHomework = false;
        });
      }
    } catch (e) {
      print("Error fetching homework: $e");
      if (mounted) setState(() => isLoadingHomework = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      drawer: _buildDrawer(context),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNoticeSection(),
            _buildHomeworkSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Center(
              child: Text('Hello Student',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
          ),
          _buildDrawerItem(
              Icons.menu_book_sharp, 'Home Work', HomeworkScreen()),
          _buildDrawerItem(Icons.person_pin, 'Attendance', AttendanceScreen()),
          _buildDrawerItem(
              Icons.description, 'Report Card', ReportCardListScreen()),
          _buildDrawerItem(
              Icons.line_weight_outlined, 'Notice Board', NoticeBoard()),
          _buildDrawerItem(Icons.logout_outlined, 'Log Out', RoleSelectionApp(),
              isLogout: true),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, Widget screen,
      {bool isLogout = false}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        if (isLogout) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => screen));
        } else {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => screen));
        }
      },
    );
  }

  Widget _buildNoticeSection() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Notice Board',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: isLoadingNotices
                ? Center(child: CircularProgressIndicator())
                : notices.isEmpty
                    ? Center(child: Text("No notices available."))
                    : ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: notices.length,
                        itemBuilder: (context, index) {
                          final notice = notices[index];
                          return _buildCard(notice['title'], notice['date'],
                              index, Icons.announcement);
                        },
                      ),
          ),
        ],
      ),
    );
  }

  Widget _buildHomeworkSection() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Homework',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 16),
          isLoadingHomework
              ? Center(child: CircularProgressIndicator())
              : homeworkList.isEmpty
                  ? Center(child: Text("No homework available."))
                  : Column(
                      children: homeworkList.map((homework) {
                        return HomeworkCard(
                          color: Colors.blue[100], // You can customize colors
                          subject: homework['subject'] ?? "No Subject",
                          title: homework['title'] ?? "No Title",
                          description:
                              homework['description'] ?? "No Description",
                          time: homework['dueDate'] ?? "No Due Date",
                        );
                      }).toList(),
                    ),
        ],
      ),
    );
  }
}

Widget _buildCard(String title, String subtitle, int index, IconData icon) {
  List<Color> cardColors = [
    Colors.blue[100]!,
    Colors.pink[100]!,
    Colors.green[100]!
  ];

  return Container(
    width: 220,
    margin: EdgeInsets.only(right: 10, bottom: 10),
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: cardColors[index % cardColors.length],
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.3),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 30, color: Colors.deepPurple),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis),
              SizedBox(height: 8),
              Text(subtitle,
                  style: TextStyle(fontSize: 12, color: Colors.black)),
            ],
          ),
        ),
      ],
    ),
  );
}
