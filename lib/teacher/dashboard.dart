// import 'package:adminschool/attendance.dart';
// import 'package:adminschool/menu.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(Dashboard());
}

class Dashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> pendingClasses = [
    {'title': 'Class 6 A', 'color': Colors.yellow},
    {'title': 'Class 8 A', 'color': Colors.blue},
    {'title': 'Class 7 A', 'color': Colors.green},
    {'title': 'Class 8 B', 'color': Colors.purple},
    {'title': 'Class 9 A', 'color': Colors.pink},
    {'title': 'Class 10 A', 'color': Colors.purple},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: Colors.black),
        //   onPressed: () {},
        // ),
        title: Text(
          'Hello, Nikita!',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: Colors.grey[300],
            child: Icon(Icons.person, color: Colors.black),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.all(16.0),
            // child: Row(
            //   children: [
            //     Icon(Icons.public, size: 60, color: Colors.teal),
            //     Spacer(),
            //     Icon(Icons.book, size: 40, color: Colors.teal),
            //   ],
            // ),
          ),
          // Class Teacher Section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Text(
              'Class Teacher',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: Colors.teal.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Menu()),
                // );
              },
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.teal,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Mrs. Priya Sharma',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      'Class 6 A',
                      style: TextStyle(fontSize: 14, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
            ),
          ),
          // Pending Class Section
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Pending Class',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                // Text(
                //   'Completed Class',
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16.0),
              itemCount: pendingClasses.length,
              itemBuilder: (context, index) {
                final item = pendingClasses[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8.0),
                  color: item['color'].withOpacity(0.2),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: item['color'],
                      child: Icon(Icons.book, color: Colors.white),
                    ),
                    title: Text(item['title']),
                    trailing: Icon(Icons.more_vert),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: 0,
      //   items: [
      //     BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
      //     BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
      //   ],
      //   selectedItemColor: Colors.teal,
      //   unselectedItemColor: Colors.grey,
      // ),
    );
  }
}
