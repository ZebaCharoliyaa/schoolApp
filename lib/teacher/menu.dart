import 'package:flutter/material.dart';
import 'package:school/teacher/addHomework.dart';
import 'package:school/teacher/addNotice.dart';
import 'package:school/teacher/addstudent.dart';
import 'package:school/teacher/attendance.dart';
import 'package:school/teacher/reportcard.dart';

class Menu extends StatelessWidget {
  // Menu items data
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.menu_book_sharp,
      'label': 'Home Work',
      'page': AddHomeworkScreen()
    },
    {'icon': Icons.person_pin, 'label': 'Attendance', 'page': AttendanceHome()},
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
    {
      'icon': Icons.person_add,
      'label': 'Add Student',
      'page': AddStudentForm()
    },
  ];

  Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hello, Nikita!",
          style: TextStyle(color: Colors.deepPurple),
        ),
        // centerTitle: true,
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
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Menu(),
  ));
}
