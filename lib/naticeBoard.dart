import 'package:flutter/material.dart';
import 'package:school/teacher/addNotice.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NoticeBoardScreen(),
    );
  }
}

class NoticeBoard extends StatelessWidget {
  final List<Map<String, dynamic>> notices = [
    {
      'title': 'School is going for vacation in next month',
      'date': '02 March 2020',
      'imageUrl': 'assets/images/pic1.jpg',
      'backgroundColor': Colors.green[100],
      'textColor': Colors.green[800],
    },
    {
      'title': 'Summer Book Fair at School Campus in June',
      'date': '02 March 2020',
      'imageUrl': 'assets/images/pic2.jpg',
      'backgroundColor': Colors.pink[100],
      'textColor': Colors.blue[800],
    },
    {
      'title': 'School is going for vacation in next month',
      'date': '02 March 2020',
      'imageUrl': 'assets/images/pic3.jpg',
      'backgroundColor': Colors.green[100],
      'textColor': Colors.green[800],
    },
    {
      'title': 'Summer Book Fair at School Campus in June',
      'date': '02 March 2020',
      'imageUrl': 'assets/images/pic1.jpg',
      'backgroundColor': Colors.pink[100],
      'textColor': Colors.blue[800],
    },
    {
      'title': 'School is going for vacation in next month',
      'date': '02 March 2020',
      'imageUrl': 'assets/images/pic2.jpg',
      'backgroundColor': Colors.green[100],
      'textColor': Colors.green[800],
    },
    {
      'title': 'Summer Book Fair at School Campus in June',
      'date': '02 March 2020',
      'imageUrl': 'assets/images/pic3.jpg',
      'backgroundColor': Colors.pink[100],
      'textColor': Colors.blue[800],
    },
    {
      'title': 'School is going for vacation in next month',
      'date': '02 March 2020',
      'imageUrl': 'assets/images/pic1.jpg',
      'backgroundColor': Colors.green[100],
      'textColor': Colors.green[800],
    },
  ];

   NoticeBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Notice Board',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          children: notices.map((notice) {
            return NoticeCard(
              title: notice['title'],
              date: notice['date'],
              imageUrl: notice['imageUrl'],
              backgroundColor: notice['backgroundColor'],
              textColor: notice['textColor'],
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
  final String imageUrl;
  final Color? backgroundColor;
  final Color? textColor;

  const NoticeCard({super.key, 
    required this.title,
    required this.date,
    required this.imageUrl,
    required this.backgroundColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4.0),
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
