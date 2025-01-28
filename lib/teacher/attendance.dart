// import 'package:flutter/material.dart';

// void main() => runApp(AttendanceApp());

// class AttendanceApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AttendanceScreen(),
//     );
//   }
// }

// class AttendanceScreen extends StatefulWidget {
//   @override
//   _AttendanceScreenState createState() => _AttendanceScreenState();
// }

// class _AttendanceScreenState extends State<AttendanceScreen> {
//   String selectedClass = '10-A'; // Default selected class

//   final List<Map<String, dynamic>> students = List.generate(
//     10,
//     (index) => {
//       'name': 'Mohan ${index + 1}',
//       'present': false,
//       'absent': false,
//     },
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//         title: Text('Attendance', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.deepPurple,
//         actions: [
//           // Class Dropdown in AppBar
//           Padding(
//             padding: EdgeInsets.only(right: 16.0),
//             child: DropdownButton<String>(
//               value: selectedClass,
//               onChanged: (String? newValue) {
//                 setState(() {
//                   selectedClass = newValue!;
//                 });
//               },
//               underline: Container(),
//               icon: Icon(Icons.arrow_drop_down, color: Colors.white),
//               items: <String>[
//                 '1-A',
//                 '1-B',
//                 '2-A',
//                 '2-B',
//                 '3-A',
//                 '3-B',
//                 '4-A',
//                 '4-B',
//                 '5-A',
//                 '5-B',
//                 '6-A',
//                 '6-B',
//                 '7-A',
//                 '7-B',
//                 '8-A',
//                 '8-B',
//                 '9-A',
//                 '9-B',
//                 '10-A',
//                 '10-B',
//                 '11',
//                 '12',
//               ].map<DropdownMenuItem<String>>((String value) {
//                 return DropdownMenuItem<String>(
//                   value: value,
//                   child: Text(
//                     value,
//                     style: TextStyle(
//                         color: selectedClass == value
//                             ? Colors.white
//                             : Colors.deepPurple),
//                   ),
//                 );
//               }).toList(),
//             ),
//           ),
//         ],
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SizedBox(height: 16),

//             // Attendance Headers
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Student Name',
//                   style: TextStyle(fontWeight: FontWeight.bold),
//                 ),
//                 Row(
//                   children: [
//                     Text(
//                       'Present',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(width: 30),
//                     Text(
//                       'Absent',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             Divider(),

//             // Attendance List
//             Expanded(
//               child: ListView.builder(
//                 itemCount: students.length,
//                 itemBuilder: (context, index) {
//                   final student = students[index];
//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         backgroundColor: Colors.deepPurple,
//                         child: Text(
//                           student['name'][0],
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       title: Text(student['name']),
//                       subtitle: Text(
//                         student['present']
//                             ? 'Status: Present'
//                             : student['absent']
//                                 ? 'Status: Absent'
//                                 : 'Status: Not Marked',
//                         style: TextStyle(
//                           color: student['present']
//                               ? Colors.green
//                               : student['absent']
//                                   ? Colors.red
//                                   : Colors.grey,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       trailing: Row(
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Checkbox(
//                             value: student['present'],
//                             onChanged: (value) {
//                               setState(() {
//                                 student['present'] = value!;
//                                 if (value) {
//                                   student['absent'] = false;
//                                 }
//                               });
//                             },
//                           ),
//                           Checkbox(
//                             value: student['absent'],
//                             onChanged: (value) {
//                               setState(() {
//                                 student['absent'] = value!;
//                                 if (value) {
//                                   student['present'] = false;
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // View Monthly Attendance Button
//             Padding(
//               padding: EdgeInsets.only(top: 16.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total Students: ${students.length}',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       fontSize: 16,
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => MonthlyAttendanceScreen(
//                             students: students,
//                           ),
//                         ),
//                       );
//                     },
//                     style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.deepPurple),
//                     child: Text(
//                       'View Monthly Attendance',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class MonthlyAttendanceScreen extends StatefulWidget {
//   final List<Map<String, dynamic>> students;

//   MonthlyAttendanceScreen({required this.students});

//   @override
//   _MonthlyAttendanceScreenState createState() =>
//       _MonthlyAttendanceScreenState();
// }

// class _MonthlyAttendanceScreenState extends State<MonthlyAttendanceScreen> {
//   String selectedMonth = 'January'; // Default selected month

//   @override
//   Widget build(BuildContext context) {
//     // Mock monthly attendance data
//     final Map<String, List<String>> monthlyData = {
//       for (var student in widget.students)
//         student['name']:
//             List.generate(30, (index) => index % 2 == 0 ? 'P' : 'A'),
//     };

//     // Calculate overall totals for the month
//     final totalPresent = monthlyData.values
//         .expand((days) => days)
//         .where((status) => status == 'P')
//         .length;
//     final totalAbsent = monthlyData.values
//         .expand((days) => days)
//         .where((status) => status == 'A')
//         .length;

//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Monthly Attendance'),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Month Dropdown Selector
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Select Month: $selectedMonth',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 DropdownButton<String>(
//                   value: selectedMonth,
//                   onChanged: (String? newValue) {
//                     setState(() {
//                       selectedMonth = newValue!;
//                     });
//                   },
//                   items: <String>[
//                     'January',
//                     'February',
//                     'March',
//                     'April',
//                     'May',
//                     'June',
//                     'July',
//                     'August',
//                     'September',
//                     'October',
//                     'November',
//                     'December'
//                   ].map<DropdownMenuItem<String>>((String value) {
//                     return DropdownMenuItem<String>(
//                       value: value,
//                       child: Text(value),
//                     );
//                   }).toList(),
//                 ),
//               ],
//             ),
//             SizedBox(height: 16),

//             // Monthly Attendance Data
//             Expanded(
//               child: ListView(
//                 children: monthlyData.entries.map((entry) {
//                   final totalPresent =
//                       entry.value.where((status) => status == 'P').length;
//                   final totalAbsent =
//                       entry.value.where((status) => status == 'A').length;

//                   return Card(
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     child: ListTile(
//                       title: Text(entry.key),
//                       subtitle: Text(
//                         'Total Present: $totalPresent, Total Absent: $totalAbsent',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';

void main() => runApp(AttendanceApp());

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AttendanceHome(),
    );
  }
}

class AttendanceHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Attendance ',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.deepPurple,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(70.0),
            child: Container(
              color: Colors.white,
              child: TabBar(
                // indicatorColor: Colors.deepPurple,
                unselectedLabelColor: Colors.deepPurple,
                // indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 6.0, // Change the thickness of the indicator
                labelStyle: TextStyle(color: Colors.black),
                tabs: [
                  Tab(
                      text: 'Mark Attendance',
                      icon: Icon(
                        Icons.edit,
                      )),
                  Tab(text: 'View Attendance', icon: Icon(Icons.view_list)),
                ],
              ),
            ),
        ),
        ),
      
        body: TabBarView(
          children: [
            AttendanceScreen(),
            ViewMonthlyAttendanceScreen(),
          ],
        ),
      ),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  String selectedClass = '10-A'; // Default selected class

  final List<Map<String, dynamic>> students = List.generate(
    10,
    (index) => {
      'name': 'Mohan ${index + 1}',
      'present': false,
      'absent': false,
    },
  );

  void _showSuccessPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Attendance has been successfully submitted!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Class:',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: selectedClass,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedClass = newValue!;
                  });
                },
                items: <String>[
                  '1-A',
                  '1-B',
                  '2-A',
                  '2-B',
                  '3-A',
                  '3-B',
                  '4-A',
                  '4-B',
                  '5-A',
                  '5-B',
                  '6-A',
                  '6-B',
                  '7-A',
                  '7-B',
                  '8-A',
                  '8-B',
                  '9-A',
                  '9-B',
                  '10-A',
                  '10-B',
                  '11',
                  '12',
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Student Name',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text('Present',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 30),
                  Text('Absent', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
          Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                final student = students[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.deepPurple,
                      child: Text(
                        student['name'][0],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Text(student['name']),
                    subtitle: Text(
                      student['present']
                          ? 'Status: Present'
                          : student['absent']
                              ? 'Status: Absent'
                              : 'Status: Not Marked',
                      style: TextStyle(
                        color: student['present']
                            ? Colors.green
                            : student['absent']
                                ? Colors.red
                                : Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Checkbox(
                          value: student['present'],
                          onChanged: (value) {
                            setState(() {
                              student['present'] = value!;
                              if (value) {
                                student['absent'] = false;
                              }
                            });
                          },
                        ),
                        Checkbox(
                          value: student['absent'],
                          onChanged: (value) {
                            setState(() {
                              student['absent'] = value!;
                              if (value) {
                                student['present'] = false;
                              }
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Students: ${students.length}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle submission logic here
                    _showSuccessPopup(context); // Show success popup
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple,
                  ),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ViewMonthlyAttendanceScreen extends StatefulWidget {
  @override
  _ViewMonthlyAttendanceScreenState createState() =>
      _ViewMonthlyAttendanceScreenState();
}

class _ViewMonthlyAttendanceScreenState
    extends State<ViewMonthlyAttendanceScreen> {
  final List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];

  String selectedMonth = 'January';

  final List<Map<String, dynamic>> studentAttendance = List.generate(
    10,
    (index) => {
      'name': 'Mohan ${index + 1}',
      'monthly': List<int>.generate(
          12, (month) => (month + 1) * 2), // Example monthly attendance
    },
  );

  int getMonthlyAttendance(int monthIndex) {
    return studentAttendance
        .map((student) => student['monthly'][monthIndex])
        .reduce((a, b) => a + b);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Month Dropdown
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Month:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: selectedMonth,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedMonth = newValue!;
                  });
                },
                items: months.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text(
            'Monthly Attendance for $selectedMonth',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: studentAttendance.length,
              itemBuilder: (context, index) {
                final student = studentAttendance[index];
                int monthIndex = months.indexOf(selectedMonth);
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: Text(student['name']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$selectedMonth Attendance: ${student['monthly'][monthIndex]} days',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
