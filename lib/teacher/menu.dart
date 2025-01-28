// import 'package:flutter/material.dart';
// import 'package:school/teacher/addHomework.dart';
// import 'package:school/teacher/addstudent.dart';
// import 'package:school/teacher/attendance.dart';

// class Menu extends StatelessWidget {
//   // Menu items data
//   final List<Map<String, dynamic>> menuItems = [
//     {
//       'icon': Icons.menu_book_sharp,
//       'label': 'Home Work',
//       'page': AddHomeworkScreen()
//     },
//     {'icon': Icons.person_pin, 'label': 'Attendance', 'page': AttendanceApp()},
//     {'icon': Icons.payment, 'label': 'Fees', 'page': ()},
//     {'icon': Icons.description, 'label': 'Report Card', 'page': ()},
//     {'icon': Icons.line_weight_outlined, 'label': 'Notice Board', 'page': ()},
//     {
//       'icon': Icons.person_add,
//       'label': 'Add Student',
//       'page': AddStudentForm()
//     },
//   ];

//   Menu({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // backgroundColor: Colors.deepPurple,
//       appBar: AppBar(
//         // backgroundColor: Colors.deepPurple,
//         title: Text(
//           "hello,Nikita !",
//           style: TextStyle(color: Colors.deepPurple),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: EdgeInsets.only(top: 50, right: 20, left: 20),
//         child: GridView.builder(
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3, // Number of items in a row
//             crossAxisSpacing: 16.0,
//             mainAxisSpacing: 16.0,
//           ),
//           itemCount: menuItems.length,
//           itemBuilder: (context, index) {
//             return GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => menuItems[index]['page'],
//                     ));
//                 // Handle menu item tap
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(
//                       content: Text(
//                     '${menuItems[index]['label']} clicked',
//                   )),
//                 );
//               },
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Icon inside a container with a circular background
//                   Container(
//                     decoration: BoxDecoration(
//                       color: Colors.deepPurple,
//                       borderRadius: BorderRadius.circular(16),
//                     ),
//                     padding: EdgeInsets.all(20),
//                     child: Icon(
//                       menuItems[index]['icon'],
//                       size: 32,
//                       color: Colors.white,
//                     ),
//                   ),
//                   SizedBox(height: 8),
//                   // Label below the icon
//                   Text(
//                     menuItems[index]['label'],
//                     style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w500,
//                         color: Colors.deepPurple),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// void main() {
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Menu(),
//   ));
// }

import 'package:flutter/material.dart';
import 'package:school/teacher/addHomework.dart';
import 'package:school/teacher/addstudent.dart';
import 'package:school/teacher/attendance.dart';

class Menu extends StatelessWidget {
  // Menu items data
  final List<Map<String, dynamic>> menuItems = [
    {
      'icon': Icons.menu_book_sharp,
      'label': 'Home Work',
      'page': AddHomeworkScreen()
    },
    {'icon': Icons.person_pin, 'label': 'Attendance', 'page': AttendanceApp()},
    {'icon': Icons.payment, 'label': 'Fees', 'page': null},
    {'icon': Icons.description, 'label': 'Report Card', 'page': null},
    {'icon': Icons.line_weight_outlined, 'label': 'Notice Board', 'page': null},
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
