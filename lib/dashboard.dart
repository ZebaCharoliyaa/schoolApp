import 'package:flutter/material.dart';
import 'package:school/accountselection.dart';
import 'package:school/attendance.dart';
import 'package:school/homework.dart';
import 'package:school/naticeBoard.dart';
import 'package:school/profile.dart';
import 'package:school/report.dart';
import 'package:school/services/api_services.dart';

class FirstPage extends StatefulWidget {
  FirstPage({super.key});

  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> notices = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchNotices(); // ✅ Fetch latest notices when screen loads
  }

  // ✅ Fetch Notices from API
  Future<void> fetchNotices() async {
    try {
      List<Map<String, dynamic>> latestNotices = await apiService.getNotices();
      latestNotices.sort((a, b) {
        DateTime dateA = DateTime.parse(a['date']);
        DateTime dateB = DateTime.parse(b['date']);
        return dateB.compareTo(dateA); // Descending order
      });
      if (mounted) {
        setState(() {
          notices =
              latestNotices.take(3).toList(); // ✅ Show only latest 3 notices
          isLoading = false;
        });
      }
    } catch (e) {
      print("Error fetching notices: $e");
      if (mounted) {
        setState(() => isLoading = false);
      }
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
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
      ),
      drawer: _buildDrawer(context), // ✅ Drawer remains unchanged
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Notice Board Section
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notice Board',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: isLoading
                        ? Center(
                            child:
                                CircularProgressIndicator()) // ✅ Loading Indicator
                        : notices.isEmpty
                            ? Center(child: Text("No notices available."))
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: notices.length,
                                itemBuilder: (context, index) {
                                  final notice = notices[index];
                                  final List<Color?> noticeColors = [
                                    Colors.pink[100],
                                    Colors.blue[100],
                                    Colors.green[100]
                                  ];
                                  final noticeColor =
                                      noticeColors[index % noticeColors.length];

                                  return Container(
                                    width: 200,
                                    margin: EdgeInsets.only(right: 10),
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: noticeColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          notice['title'],
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Spacer(), // Pushes the date to the bottom
                                        Align(
                                          alignment: Alignment.bottomLeft,
                                          child: Text(
                                            notice['date'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                  ),
                ],
              ),
            ),

            // ✅ Homework Section (No changes)
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Homework',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 3, // Replace with actual homework data count
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.book, color: Colors.deepPurple),
                          title: Text('Homework Title'),
                          subtitle: Text('Subject details and deadlines'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ✅ Drawer remains unchanged
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
          ListTile(
            leading: Icon(Icons.menu_book_sharp),
            title: Text('Home Work'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeworkScreen())),
          ),
          ListTile(
            leading: Icon(Icons.person_pin),
            title: Text('Attendance'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AttendanceScreen())),
          ),
          ListTile(
            leading: Icon(Icons.description),
            title: Text('Report Card'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ReportCardListScreen())),
          ),
          ListTile(
            leading: Icon(Icons.line_weight_outlined),
            title: Text('Notice Board'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => NoticeBoard())),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AnimatedStudentProfile())),
          ),
          ListTile(
            leading: Icon(Icons.person_add),
            title: Text('Add Account'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => RoleSelectionApp())),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text('Log Out'),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => RoleSelectionApp())),
          ),
        ],
      ),
    );
  }
}
