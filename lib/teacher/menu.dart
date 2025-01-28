// import 'package:adminschool/addHomework.dart';
// import 'package:adminschool/addstudent.dart';
// import 'package:adminschool/attendance.dart';
import 'package:flutter/material.dart';
import 'package:school/teacher/addHomework.dart';
import 'package:school/teacher/addstudent.dart';
import 'package:school/teacher/attendance.dart';
// import 'package:school/attendance.dart';
// import 'package:school/calander.dart';
// import 'package:school/dashboard.dart';
// import 'package:school/examination.dart';
// import 'package:school/fees.dart';
// import 'package:school/forgot.dart';
// import 'package:school/homework.dart';
// import 'package:school/multimedia.dart';
// import 'package:school/naticeBoard.dart';
// import 'package:school/profile.dart';
// import 'package:school/report.dart';
// import 'package:school/signIn.dart';

class Menu extends StatelessWidget {
  // Menu items data
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.menu_book_sharp,
      'label': 'Home Work',
      'page': AddHomeworkScreen()
    },
    {'icon': Icons.person_pin, 'label': 'Attendance', 'page': AttendanceApp()},
    {'icon': Icons.payment, 'label': 'Fees', 'page': ()},
    {'icon': Icons.laptop_outlined, 'label': 'Multimedia', 'page': ()},
    {'icon': Icons.assignment_sharp, 'label': 'Exammination', 'page': ()},
    {'icon': Icons.description, 'label': 'Report Card', 'page': ()},
    {'icon': Icons.line_weight_outlined, 'label': 'Notice Board', 'page': ()},
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
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "hello,Nikita !",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        
        
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 50, right: 20, left: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // Number of items in a row
            crossAxisSpacing: 16.0,
            mainAxisSpacing: 16.0,
          ),
          itemCount: menuItems.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => menuItems[index]['page'],
                    ));
                // Handle menu item tap
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                      content: Text(
                    '${menuItems[index]['label']} clicked',
                  )),
                );
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Icon inside a container with a circular background
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: EdgeInsets.all(20),
                    child: Icon(
                      menuItems[index]['icon'],
                      size: 32,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  // Label below the icon
                  Text(
                    menuItems[index]['label'],
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
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
