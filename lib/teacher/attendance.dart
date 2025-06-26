import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/services/api_services.dart';

class AttendanceScreen extends StatefulWidget {
  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ApiService apiService = ApiService();

  String selectedStandard = '10-A';
  String selectedMonth = 'June';
  List<Map<String, dynamic>> students = [];
  Map<String, Map<String, String>> monthlyAttendance = {};
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
    fetchStudents();
    fetchMonthly();
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
      students = [];
    }
    setState(() => isLoading = false);
  }

  Future<void> fetchMonthly() async {
    final year = DateTime.now().year.toString();
    final data = await apiService.getMonthlyAttendance(
        selectedStandard, year, selectedMonth);
    setState(() => monthlyAttendance = data);
  }

  void onMonthChanged(String? value) {
    if (value != null) {
      setState(() => selectedMonth = value);
      fetchMonthly();
    }
  }

  void onStandardChanged(String? value) {
    if (value != null) {
      setState(() => selectedStandard = value);
      fetchStudents();
      fetchMonthly();
    }
  }

  Future<void> submitAttendance() async {
    final now = DateTime.now();
    final String year = now.year.toString();
    final String month = months[now.month - 1];
    final String day = now.day.toString();

    await apiService.submitAttendance(
      selectedStandard,
      year,
      month,
      day,
      students,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Attendance Submitted!")),
    );

    fetchMonthly();
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
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Select Standard:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: selectedStandard,
              onChanged: onStandardChanged,
              items: standards
                  .map((val) => DropdownMenuItem(value: val, child: Text(val)))
                  .toList(),
            ),
          ]),
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
                              child: Text(student['name'][0].toUpperCase(),
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
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Total Students: ${students.length}',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text('Present: $totalPresent, Absent: $totalAbsent',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                ]),
                ElevatedButton(
                  onPressed: submitAttendance,
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
    final totalPresent = monthlyAttendance.values
        .expand((m) => m.values)
        .where((s) => s == 'P')
        .length;
    final totalAbsent = monthlyAttendance.values
        .expand((m) => m.values)
        .where((s) => s == 'A')
        .length;

    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('Select Month:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          DropdownButton<String>(
            value: selectedMonth,
            onChanged: onMonthChanged,
            items: months
                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
                .toList(),
          ),
        ]),
        SizedBox(height: 16),
        Text('Total Present: $totalPresent\nTotal Absent: $totalAbsent',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        SizedBox(height: 16),
        Expanded(
          child: ListView(
            children: monthlyAttendance.entries.map((entry) {
              final name = entry.key;
              final records = entry.value;
              final p = records.values.where((s) => s == 'P').length;
              final a = records.values.where((s) => s == 'A').length;

              return ListTile(
                title: Text(name),
                subtitle: Text('Present: $p, Absent: $a'),
              );
            }).toList(),
          ),
        )
      ]),
    );
  }
}
