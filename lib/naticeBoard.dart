// import 'package:flutter/material.dart';

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: NoticeBoard(),
//     );
//   }
// }

// class NoticeBoard extends StatelessWidget {
//   final List<Map<String, dynamic>> notices = [
//     {
//       'title': 'School is going for vacation in next month',
//       'date': '02 March 2020',
//       'imageUrl': 'assets/images/pic1.jpg',
//       'backgroundColor': Colors.green[100],
//       'textColor': Colors.green[800],
//     },
//     {
//       'title': 'Summer Book Fair at School Campus in June',
//       'date': '02 March 2020',
//       'imageUrl': 'assets/images/pic2.jpg',
//       'backgroundColor': Colors.pink[100],
//       'textColor': Colors.blue[800],
//     },
//     {
//       'title': 'School is going for vacation in next month',
//       'date': '02 March 2020',
//       'imageUrl': 'assets/images/pic3.jpg',
//       'backgroundColor': Colors.green[100],
//       'textColor': Colors.green[800],
//     },
//     {
//       'title': 'Summer Book Fair at School Campus in June',
//       'date': '02 March 2020',
//       'imageUrl': 'assets/images/pic1.jpg',
//       'backgroundColor': Colors.pink[100],
//       'textColor': Colors.blue[800],
//     },
//     {
//       'title': 'School is going for vacation in next month',
//       'date': '02 March 2020',
//       'imageUrl': 'assets/images/pic2.jpg',
//       'backgroundColor': Colors.green[100],
//       'textColor': Colors.green[800],
//     },
//     {
//       'title': 'Summer Book Fair at School Campus in June',
//       'date': '02 March 2020',
//       'imageUrl': 'assets/images/pic3.jpg',
//       'backgroundColor': Colors.pink[100],
//       'textColor': Colors.blue[800],
//     },
//     {
//       'title': 'School is going for vacation in next month',
//       'date': '02 March 2020',
//       'imageUrl': 'assets/images/pic1.jpg',
//       'backgroundColor': Colors.green[100],
//       'textColor': Colors.green[800],
//     },
//   ];

//    NoticeBoard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: const Icon(
//             Icons.arrow_back,
//             color: Colors.white,
//           ),
//         ),
//         title: const Text(
//           'Notice Board',
//           style: TextStyle(color: Colors.white),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: GridView.count(
//           crossAxisCount: 2, // Two items per row
//           crossAxisSpacing: 8.0,
//           mainAxisSpacing: 8.0,
//           children: notices.map((notice) {
//             return NoticeCard(
//               title: notice['title'],
//               date: notice['date'],
//               imageUrl: notice['imageUrl'],
//               backgroundColor: notice['backgroundColor'],
//               textColor: notice['textColor'],
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }

// class NoticeCard extends StatelessWidget {
//   final String title;
//   final String date;
//   final String imageUrl;
//   final Color? backgroundColor;
//   final Color? textColor;

//   const NoticeCard({super.key,
//     required this.title,
//     required this.date,
//     required this.imageUrl,
//     required this.backgroundColor,
//     required this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(8.0),
//             child: Image.network(
//               imageUrl,
//               height: 100,
//               width: double.infinity,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             title,
//             style: TextStyle(
//               color: textColor,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 4.0),
//           Text(
//             date,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 12.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

//new

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: NoticeBoard(),
//     );
//   }
// }

// class NoticeBoard extends StatefulWidget {
//   const NoticeBoard({super.key});

//   @override
//   _NoticeBoardState createState() => _NoticeBoardState();
// }

// class _NoticeBoardState extends State<NoticeBoard> {
//   final DatabaseReference _database =
//       FirebaseDatabase.instance.ref().child('notices');

//   List<Map<String, dynamic>> notices = [];

//   @override
//   void initState() {
//     super.initState();
//     _fetchNotices(); // Fetch notices from Firebase
//   }

//   void _fetchNotices() {
//     _database.onValue.listen((event) {
//       final data = event.snapshot.value;
//       if (data != null && data is Map) {
//         List<Map<String, dynamic>> tempList = [];
//         data.forEach((key, value) {
//           tempList.add({
//             'id': key,
//             'title': value['title'] ?? 'No Title',
//             'date': value['date'] ?? 'No Date',
//             // 'backgroundColor': Colors.green[100],
//             // 'textColor': Colors.green[800],
//           });
//         });

//         setState(() {
//           notices = tempList.reversed.toList(); // Show latest notices first
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(
//             bottom: Radius.circular(20),
//           ),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         title:
//             const Text('Notice Board', style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: notices.isEmpty
//             ? const Center(child: Text("No notices available."))
//             : GridView.count(
//                 crossAxisCount: 2, // Two items per row
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 children: notices.map((notice) {
//                   return NoticeCard(
//                     title: notice['title'],
//                     date: notice['date'],
//                     // backgroundColor: notice['backgroundColor'],
//                     // textColor: notice['textColor'],
//                   );
//                 }).toList(),
//               ),
//       ),
//     );
//   }
// }

// class NoticeCard extends StatelessWidget {
//   final String title;
//   final String date;
//   // final Color? backgroundColor;
//   // final Color? textColor;

//   const NoticeCard({
//     super.key,
//     required this.title,
//     required this.date,
//     // required this.backgroundColor,
//     // required this.textColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         // color: backgroundColor,
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               // color: textColor,
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             date,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 12.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:school/services/api_services.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(); // Initialize Firebase
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: NoticeBoard(),
//     );
//   }
// }

// class NoticeBoard extends StatefulWidget {
//   const NoticeBoard({super.key});

//   @override
//   _NoticeBoardState createState() => _NoticeBoardState();
// }

// class _NoticeBoardState extends State<NoticeBoard> {
//   final DatabaseReference _database =
//       FirebaseDatabase.instance.ref().child('notice_board');
//   List<Map<String, dynamic>> notices = [];

//   @override
//   void initState() {
//     super.initState();
//     _listenToNotices(); // ✅ Start real-time listening
//   }

//   // ✅ Correct Firebase Listener for Realtime Updates
//   void _listenToNotices() {
//     _database.onValue.listen((event) {
//       final data = event.snapshot.value;
//       if (data != null && data is Map) {
//         List<Map<String, dynamic>> tempList = [];
//         data.forEach((key, value) {
//           tempList.add({
//             'id': key,
//             'title': value['title'] ?? 'No Title',
//             'date': value['date'] ?? 'No Date',
//           });
//         });

//         setState(() {
//           notices = tempList.reversed.toList(); // Show latest notices first
//         });
//       } else {
//         setState(() {
//           notices = [];
//         });
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         shape: const RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.deepPurple,
//         title:
//             const Text('Notice Board', style: TextStyle(color: Colors.white)),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: notices.isEmpty
//             ? const Center(child: Text("No notices available."))
//             : GridView.count(
//                 crossAxisCount: 2, // Two items per row
//                 crossAxisSpacing: 8.0,
//                 mainAxisSpacing: 8.0,
//                 children: notices.map((notice) {
//                   return NoticeCard(
//                     title: notice['title'],
//                     date: notice['date'],
//                   );
//                 }).toList(),
//               ),
//       ),
//     );
//   }
// }

// class NoticeCard extends StatelessWidget {
//   final String title;
//   final String date;

//   const NoticeCard({
//     super.key,
//     required this.title,
//     required this.date,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//         color: Colors.deepPurple[50],
//         borderRadius: BorderRadius.circular(8.0),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           const SizedBox(height: 8.0),
//           Text(
//             date,
//             style: TextStyle(
//               color: Colors.grey[600],
//               fontSize: 12.0,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';

class NoticeBoard extends StatefulWidget {
  const NoticeBoard({super.key});

  @override
  _NoticeBoardState createState() => _NoticeBoardState();
}

class _NoticeBoardState extends State<NoticeBoard> {
  final ApiService apiService = ApiService();
  List<Map<String, dynamic>> notices = [];
  bool isLoading = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchNotices(); // ✅ Fetch notices when screen loads
    _startAutoRefresh(); // ✅ Automatically fetch notices
  }

  // ✅ Fetch Notices from API
  Future<void> fetchNotices() async {
    try {
      List<Map<String, dynamic>> newNotices = await apiService.getNotices();
      if (mounted) {
        setState(() {
          notices = newNotices;
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

  // ✅ Automatically Refresh Notices Every 30 Seconds
  void _startAutoRefresh() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      fetchNotices();
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // ✅ Stop auto-refresh when the screen is closed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        title: const Text('Notice Board', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator()) // ✅ Show loading indicator
            : notices.isEmpty
                ? const Center(child: Text("No notices available."))
                : GridView.count(
                    crossAxisCount: 2, // Two items per row
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                    children: notices.map((notice) {
                      return NoticeCard(
                        title: notice['title'],
                        date: notice['date'],
                      );
                    }).toList(),
                  ),
      ),
    );
  }
}

class NoticeCard extends StatelessWidget {
  final String title;
  final String date;

  const NoticeCard({
    super.key,
    required this.title,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.deepPurple[50],
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            date,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12.0,
            ),
          ),
        ],
      ),
    );
  }
}
