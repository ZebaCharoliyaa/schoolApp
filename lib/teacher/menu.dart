import 'package:flutter/material.dart';
import 'package:school/accountselection.dart';
import 'package:school/naticeBoard.dart';
import 'package:school/services/auth_service.dart';
import 'package:school/teacher/addHomework.dart';
import 'package:school/teacher/addNotice.dart';
import 'package:school/teacher/addstudent.dart';
import 'package:school/teacher/attendance.dart';
import 'package:school/teacher/reportcard.dart';
// import 'package:school/auth_service.dart';  // Make sure to import AuthService for session handling

class Menu extends StatelessWidget {
  // Menu items data
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.menu_book_sharp,
      'label': 'Home Work',
      'page': AddHomeworkScreen()
    },
    {
      'icon': Icons.person_pin,
      'label': 'Attendance',
      'page': AttendanceScreen()
    },
    {
      'icon': Icons.description,
      'label': 'Report Card',
      'page': SelectClassScreen()
    },
    {
      'icon': Icons.line_weight_outlined,
      'label': 'Notice Board',
      'page': AdminNoticeBoard()
    },
    {'icon': Icons.person_add, 'label': 'Add Student', 'page': StudentScreen()},
  ];

  Menu({super.key});

  // Logout method that clears session and navigates to RoleSelectionScreen
  void logout(BuildContext context) async {
    // Clear session data when logging out
    await AuthService.logout();
    print("🧹 Session Cleared");

    // Navigate to Role Selection Screen after logging out
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => RoleSelectionScreen()),
    );
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
        title:
            const Text('Hello Nikita!', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
            childAspectRatio: 1.2, // Adjust aspect ratio
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                if (menuItems[index]['page'] != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => menuItems[index]['page'],
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${menuItems[index]['label']} is not available yet!'),
                    ),
                  );
                }
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(menuItems[index]['icon'],
                        size: 50, color: Colors.deepPurple),
                    SizedBox(height: 10),
                    Text(
                      menuItems[index]['label'],
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => logout(context), // Call the logout method when pressed
        child: Icon(Icons.logout),
        onPressed: () => logout(context), // Call the logout method when pressed
        child: Icon(
          Icons.logout,
          color: Colors.white,
        ),
        backgroundColor: Colors.deepPurple,
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Menu(),
  ));
}
