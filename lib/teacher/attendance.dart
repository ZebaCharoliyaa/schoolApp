//new code as fetch data ....

import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';

void main() => runApp(AttendanceApp());

class AttendanceApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: AttendanceScreen(),
    );
  }
}

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiService apiService = ApiService();

  String selectedStandard = '10-A';
  String selectedMonth = 'January';
  List<Map<String, dynamic>> students = [];
  bool isLoading = false;

  final List<String> standards = [
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
    '12'
  ];

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

  int get totalPresent =>
      students.where((student) => student['present'] == true).length;

  int get totalAbsent =>
      students.where((student) => student['absent'] == true).length;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    fetchStudents(); // ✅ Fetch students when the screen loads
  }

  Future<void> fetchStudents() async {
    setState(() => isLoading = true);
    try {
      students = await apiService.getStudents(selectedStandard);
      for (var student in students) {
        student['present'] = false;
        student['absent'] = false;
      }
    } catch (e) {
      print("Error fetching students: $e");
      students = [];
    }
    setState(() => isLoading = false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Management',
            style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: "Daily Attendance"),
            Tab(text: "Monthly Attendance"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDailyAttendance(),
          _buildMonthlyAttendance(),
        ],
      ),
    );
  }

  Widget _buildDailyAttendance() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Standard:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              DropdownButton<String>(
                value: selectedStandard,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedStandard = newValue!;
                  });
                  fetchStudents(); // ✅ Fetch students dynamically
                },
                items: standards.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: TextStyle(color: Colors.black)),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 16),
          if (isLoading)
            Center(child: CircularProgressIndicator())
          else
            Expanded(
              child: students.isEmpty
                  ? Center(child: Text("No students found"))
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return Card(
                          margin: EdgeInsets.symmetric(vertical: 8),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: Colors.deepPurple,
                              child: Text(student['name'][0],
                                  style: TextStyle(color: Colors.white)),
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
                                      if (value) student['absent'] = false;
                                    });
                                  },
                                ),
                                Checkbox(
                                  value: student['absent'],
                                  onChanged: (value) {
                                    setState(() {
                                      student['absent'] = value!;
                                      if (value) student['present'] = false;
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Total Students: ${students.length}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    Text('Present: $totalPresent, Absent: $totalAbsent',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Attendance Submitted!")),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple),
                  child: Text('Submit', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMonthlyAttendance() {
    final Map<String, List<String>> monthlyData = {
      for (var student in students)
        student['name']:
            List.generate(30, (index) => index % 2 == 0 ? 'P' : 'A'),
    };

    final totalPresent = monthlyData.values
        .expand((days) => days)
        .where((status) => status == 'P')
        .length;
    final totalAbsent = monthlyData.values
        .expand((days) => days)
        .where((status) => status == 'A')
        .length;

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Month:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                    child: Text(value, style: TextStyle(color: Colors.black)),
                  );
                }).toList(),
              ),
            ],
          ),
          SizedBox(height: 16),
          Text('Total Present: $totalPresent\nTotal Absent: $totalAbsent',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          SizedBox(height: 16),
          Expanded(
            child: ListView(
              children: monthlyData.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  subtitle: Text(
                      'Present: ${entry.value.where((s) => s == "P").length}, Absent: ${entry.value.where((s) => s == "A").length}'),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
