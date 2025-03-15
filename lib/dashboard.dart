// import 'package:flutter/material.dart';
// import 'package:school/accountselection.dart';
// import 'package:school/attendance.dart';
// import 'package:school/fees.dart';
// import 'package:school/homework.dart';
// import 'package:school/naticeBoard.dart';
// import 'package:school/profile.dart';
// import 'package:school/report.dart';

// class firstpage extends StatelessWidget {
//   const firstpage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Dashboard',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: Icon(Icons.menu, color: Colors.white),
//             onPressed: () {
//               Scaffold.of(context).openDrawer();
//             },
//           ),
//         ),
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//       ),
//       drawer: Drawer(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: <Widget>[
//             DrawerHeader(
//               decoration: BoxDecoration(
//                 color: Colors.deepPurple,
//               ),
//               child: Center(
//                 child: Text(
//                   'Hello Student',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 24,
//                   ),
//                 ),
//               ),
//             ),
//             ListTile(
//               leading: Icon(Icons.menu_book_sharp),
//               title: Text('Home Work'),
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => HomeworkScreen(),
//                     ));
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.person_pin),
//               title: Text('Attendance'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AttendanceScreen(),
//                   ),
//                 );
//               },
//             ),
//             // ListTile(
//             //   leading: Icon(Icons.payment),
//             //   title: Text('Fees'),
//             //   onTap: () {
//             //     Navigator.push(
//             //       context,
//             //       MaterialPageRoute(
//             //         builder: (context) => FeesDetailsScreen(),
//             //       ),
//             //     );
//             //   },
//             // ),
//             ListTile(
//               leading: Icon(Icons.description),
//               title: Text('Report Card'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => ReportCardListScreen(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.line_weight_outlined),
//               title: Text('Notice Board'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => NoticeBoard(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.person),
//               title: Text('Profile'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => AnimatedStudentProfile(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.person_add),
//               title: Text('Add Account'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => RoleSelectionApp(),
//                   ),
//                 );
//               },
//             ),
//             ListTile(
//               leading: Icon(Icons.logout_outlined),
//               title: Text('Log Out'),
//               onTap: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => RoleSelectionApp(),
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       ),

//       //   shape: RoundedRectangleBorder(
//       //     borderRadius: BorderRadius.vertical(
//       //       bottom: Radius.circular(20),
//       //     ),
//       //   ),
//       // ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Notice Board Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Notice Board',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   Container(
//                     height: 150,
//                     child: ListView.builder(
//                       shrinkWrap: true,
//                       scrollDirection: Axis.horizontal,
//                       itemCount: 3,
//                       itemBuilder: (context, index) {
//                         // Example data for notices
//                         final List<Map<String, String>> notices = [
//                           {
//                             'text': 'School is going for vacation in June',
//                             'image': 'assets/images/pic1.jpg',
//                           },
//                           {
//                             'text': 'Book Fair is scheduled for next month',
//                             'image': 'assets/images/pic2.jpg',
//                           },
//                           {
//                             'text': 'School Campus will be closed on 02 March',
//                             'image': 'assets/images/pic3.jpg',
//                           },
//                         ];
//                         final List<Color> colors = [
//                           Colors.green.shade100,
//                           Colors.pink.shade100,
//                           Colors.blue.shade100,
//                         ];

//                         return Container(
//                           width: 200, // Adjust width for horizontal scrolling
//                           margin: EdgeInsets.only(right: 10),
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             color: colors[index % colors.length],
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(8),
//                             // color: Colors.white,
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               ClipRRect(
//                                 borderRadius: BorderRadius.circular(8),
//                                 child: Image.asset(
//                                   notices[index]['image']!,
//                                   height: 40, // Adjust image size
//                                   width: 40,
//                                   fit: BoxFit.cover,
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               Expanded(
//                                 child: Text(
//                                   notices[index]['text']!,
//                                   style: TextStyle(fontSize: 16),
//                                   maxLines: 3,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),

//             // Homework Section
//             Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Homework',
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(height: 16),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     physics: NeverScrollableScrollPhysics(),
//                     itemCount: 3, // Replace with actual homework data count
//                     itemBuilder: (context, index) {
//                       return Card(
//                         color: Colors.white,
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                         child: ListTile(
//                           leading: Icon(
//                             Icons.book,
//                             color: Colors.deepPurple,
//                           ),
//                           title: Text('Homework Title ${index + 1}'),
//                           subtitle: Text('Subject details and deadlines'),
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             ),

//             // Other sections can be added here
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';
import 'package:school/naticeBoard.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

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
    fetchNotices(); // ✅ Fetch notices when screen loads
  }

  // ✅ Fetch Latest Notices from API
  Future<void> fetchNotices() async {
    try {
      List<Map<String, dynamic>> latestNotices = await apiService.getNotices();
      if (mounted) {
        setState(() {
          notices = latestNotices.take(3).toList(); // ✅ Show only latest 3 notices
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
        title: const Text('Dashboard', style: TextStyle(color: Colors.white)),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Notice Board Section
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Notice Board',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 150,
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator()) // ✅ Loading Indicator
                        : notices.isEmpty
                            ? const Center(child: Text("No notices available."))
                            : ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: notices.length,
                                itemBuilder: (context, index) {
                                  final notice = notices[index];
                                  return Container(
                                    width: 200,
                                    margin: const EdgeInsets.only(right: 10),
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: Colors.deepPurple[50],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Icon(Icons.notifications, color: Colors.deepPurple, size: 40),
                                        const SizedBox(height: 10),
                                        Text(
                                          notice['title'],
                                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 5),
                                        Text(
                                          notice['date'],
                                          style: const TextStyle(fontSize: 12, color: Colors.grey),
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

            // ✅ Homework Section (Can remain the same)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Homework',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 3, // Replace with actual homework data count
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.white,
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const ListTile(
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
}
 