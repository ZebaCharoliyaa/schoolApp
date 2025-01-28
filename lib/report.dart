import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ReportCardListScreen(),
    );
  }
}

class ReportCardListScreen extends StatelessWidget {
  const ReportCardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text(
            'Report Cards',
            style: TextStyle(color: Colors.white),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ))),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: classes.length,
        itemBuilder: (context, index) {
          return SizedBox(
            height: 80,
            child: Card(
              color: colors[index % colors.length],
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: ListTile(
                  title: Text(
                    classes[index],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to the detailed report card screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StudentProfileScreen()
                          // ReportCardScreen(className: classes[index]),
                          ),
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// Dummy list of classes
final List<String> classes = [
  'Class 7th (2015-16)',
  'Class 8th (2016-17)',
  'Class 9th (2017-18)',
  'Class 10th (2018-19)',
  'Class 11th (2019-20)',
  'Class 12th (2020-21)',
];
final List<Color> colors = [
  // Colors.blue.shade100,
  // Colors.green.shade100,
  // Colors.orange.shade100,
  Colors.green.shade100,
  Colors.pink.shade100,
  Colors.blue.shade100,
];

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        title: const Text(
          'Class 12th',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileHeader(),
            SizedBox(height: 16.0),
            AttendanceSection(),
            SizedBox(height: 16.0),
            AcademicPerformanceSection(),
            SizedBox(height: 16.0),
            RemarksSection(),
          ],
        ),
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage(
                      'assets/images/profilepic.jpg'), // Replace with your asset image
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Yugito Shoje',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.0),
                      Text('Roll Number: C015'),
                      Text('Date of Birth: 10 Oct 1996'),
                      Text('Emergency Contact: 9876543210'),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(child: Text('Father: Mr. Shoje Shoje')),
                Expanded(child: Text('Mother: Mrs. Shoje Shoje')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceSection extends StatelessWidget {
  const AttendanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            AttendanceRow(term: 'Term 1', attendance: '225 / 234 Days'),
            AttendanceRow(term: 'Term 2', attendance: '235 / 234 Days'),
          ],
        ),
      ),
    );
  }
}

class AttendanceRow extends StatelessWidget {
  final String term;
  final String attendance;

  const AttendanceRow({super.key, required this.term, required this.attendance});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(term),
          Text(attendance, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class AcademicPerformanceSection extends StatelessWidget {
  const AcademicPerformanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Academic Performance',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            PerformanceTable(term: 'Term 1'),
            SizedBox(height: 16.0),
            PerformanceTable(term: 'Term 2'),
            SizedBox(height: 16.0),
            PerformanceTable(term: 'Final'),
          ],
        ),
      ),
    );
  }
}

class PerformanceTable extends StatelessWidget {
  final String term;

  const PerformanceTable({super.key, required this.term});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          term,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4.0),
        Table(
          border: TableBorder.all(color: Colors.grey),
          columnWidths: const {
            0: FlexColumnWidth(),
            1: FixedColumnWidth(80.0),
            2: FixedColumnWidth(80.0),
          },
          children: [
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[200]),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Subject',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Grade',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Average',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('English'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('A'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('90%'),
                ),
              ],
            ),
            TableRow(
              decoration: BoxDecoration(color: Colors.grey[100]),
              children: const [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Mathematics'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('A'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('85%'),
                ),
              ],
            ),
            const TableRow(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Science'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('B'),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('75%'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class RemarksSection extends StatelessWidget {
  const RemarksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 4,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Remarks by Teacher',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              'Yugito has shown exceptional growth this year and has been a consistent performer in academics. Keep up the good work!',
            ),
          ],
        ),
      ),
    );
  }
}
