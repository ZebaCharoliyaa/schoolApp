import 'package:flutter/material.dart';
import 'package:school/attendance.dart';
import 'package:school/calander.dart';
import 'package:school/dashboard.dart';
import 'package:school/examination.dart';
import 'package:school/fees.dart';
// import 'package:school/forgot.dart';
import 'package:school/homework.dart';
import 'package:school/multimedia.dart';
import 'package:school/naticeBoard.dart';
import 'package:school/profile.dart';
import 'package:school/report.dart';
import 'package:school/signIn.dart';

class MenuScreen extends StatelessWidget {
  // Menu items data
  final List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.dashboard, 'label': 'Dashboard', 'page': firstpage()},
    {
      'icon': Icons.menu_book_sharp,
      'label': 'Home Work',
      'page': HomeworkScreen()
    },
    {
      'icon': Icons.person_pin,
      'label': 'Attendance',
      'page': AttendanceScreen()
    },
    {
      'icon': Icons.calendar_month_outlined,
      'label': 'Calander',
      'page': Calendar()
    },
    {'icon': Icons.payment, 'label': 'Fees', 'page': FeesDetailsScreen()},
    {
      'icon': Icons.laptop_outlined,
      'label': 'Multimedia',
      'page': MultimediaScreen()
    },
    {
      'icon': Icons.assignment_sharp,
      'label': 'Exammination',
      'page': ExaminationScreen()
    },
    {
      'icon': Icons.description,
      'label': 'Report Card',
      'page': ReportCardListScreen()
    },
    {
      'icon': Icons.line_weight_outlined,
      'label': 'Notice Board',
      'page': NoticeBoard()
    },
    {
      'icon': Icons.person,
      'label': 'profile',
      'page': AnimatedStudentProfile()
    },
    {'icon': Icons.person_add, 'label': 'Add Account', 'page': SignInScreen()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          "Menu",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        actions: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment:
                    MainAxisAlignment.center, // Align to the right
                children: [
                  Text(
                    "UserName",
                    style: TextStyle(fontSize: 14, color: Colors.white),
                  ),
                  Text(
                    "Class",
                    style: TextStyle(fontSize: 12, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(width: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnimatedStudentProfile(),
                      ));
                },
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/images/profilepic.jpg"),
                ),
              ),

              SizedBox(width: 8), // Optional spacing for better layout
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
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
                    padding: const EdgeInsets.all(20),
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
    home: MenuScreen(),
  ));
}
