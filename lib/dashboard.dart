import 'package:flutter/material.dart';
import 'package:school/attendance.dart';
import 'package:school/calander.dart';
import 'package:school/examination.dart';
import 'package:school/fees.dart';
import 'package:school/homework.dart';
import 'package:school/menu.dart';
import 'package:school/multimedia.dart';
import 'package:school/naticeBoard.dart';
import 'package:school/profile.dart';
import 'package:school/report.dart';
import 'package:school/signIn.dart';
import 'package:school/splash2.dart';

class firstpage extends StatelessWidget {
  const firstpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: TextStyle(color: Colors.white),
        ),
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
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.menu_book_sharp),
              title: Text('Home Work'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeworkScreen(),
                    ));
              },
            ),
            ListTile(
              leading: Icon(Icons.person_pin),
              title: Text('Attendance'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendanceScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.payment),
              title: Text('Fees'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FeesDetailsScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.laptop_outlined),
              title: Text('Multimedia'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MultimediaScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.assignment_sharp),
              title: Text('Examination'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExaminationScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Report Card'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportCardListScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.line_weight_outlined),
              title: Text('Notice Board'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NoticeBoard(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.calendar_month_outlined),
              title: Text('Calender'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Calendar(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AnimatedStudentProfile(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.person_add),
              title: Text('Add Account'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined),
              title: Text('Log Out'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignInScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),

      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.vertical(
      //       bottom: Radius.circular(20),
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Notice Board Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Notice Board',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 16),
                  Container(
                    height: 150,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        // Example data for notices
                        final List<Map<String, String>> notices = [
                          {
                            'text': 'School is going for vacation in June',
                            'image': 'assets/images/pic1.jpg',
                          },
                          {
                            'text': 'Book Fair is scheduled for next month',
                            'image': 'assets/images/pic2.jpg',
                          },
                          {
                            'text': 'School Campus will be closed on 02 March',
                            'image': 'assets/images/pic3.jpg',
                          },
                        ];
                        final List<Color> colors = [
                          Colors.green.shade100,
                          Colors.pink.shade100,
                          Colors.blue.shade100,
                        ];

                        return Container(
                          width: 200, // Adjust width for horizontal scrolling
                          margin: EdgeInsets.only(right: 10),
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: colors[index % colors.length],
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                            // color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.asset(
                                  notices[index]['image']!,
                                  height: 40, // Adjust image size
                                  width: 40,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  notices[index]['text']!,
                                  style: TextStyle(fontSize: 16),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
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

            // Homework Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Homework',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                          leading: Icon(
                            Icons.book,
                            color: Colors.deepPurple,
                          ),
                          title: Text('Homework Title ${index + 1}'),
                          subtitle: Text('Subject details and deadlines'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Other sections can be added here
          ],
        ),
      ),
    );
  }
}
