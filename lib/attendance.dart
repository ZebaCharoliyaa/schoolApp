import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final List<String> academicYears = ['2018-19', '2019-20', '2020-21'];
  String selectedAcademicYear = '2020-21';
  final List<Map<String, dynamic>> monthsAttendance = [
    {'month': 'APR', 'present': 23, 'absent': 3, 'leave': 0},
    {'month': 'MAY', 'present': 24, 'absent': 0, 'leave': 3},
    {'month': 'JUN', 'present': 25, 'absent': 0, 'leave': 1},
    {'month': 'JUL', 'present': 26, 'absent': 0, 'leave': 0},
    {'month': 'AUG', 'present': 23, 'absent': 3, 'leave': 0},
    {'month': 'SEP', 'present': 23, 'absent': 3, 'leave': 0},
    {'month': 'OCT', 'present': 23, 'absent': 3, 'leave': 0},
    {'month': 'NOV', 'present': 23, 'absent': 3, 'leave': 0},
    {'month': 'DEC', 'present': 23, 'absent': 3, 'leave': 0},
    {'month': 'JAN', 'present': 23, 'absent': 3, 'leave': 0},
  ];
  final List<Color> colors = [
    Colors.green.shade100,
    Colors.pink.shade100,
    Colors.blue.shade100,
  ];

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        title: const Text(
          'Attendance',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          DropdownButton<String>(
            value: selectedAcademicYear,
            dropdownColor: Colors.deepPurple,
            onChanged: (newValue) {
              setState(() {
                selectedAcademicYear = newValue!;
              });
            },
            items: academicYears.map((year) {
              return DropdownMenuItem<String>(
                value: year,
                child: Text(
                  year,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: screenHeight * 0.02),
            Expanded(
              child: ListView.builder(
                itemCount: monthsAttendance.length,
                itemBuilder: (context, index) {
                  final monthData = monthsAttendance[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MonthlyAttendanceScreen(
                            month: monthData['month'],
                            present: monthData['present'],
                            absent: monthData['absent'],
                            leave: monthData['leave'],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      color: colors[index % colors.length],
                      elevation: 4.0,
                      margin:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                      child: Padding(
                        padding: EdgeInsets.all(screenWidth * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              monthData['month'],
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                _statusWidget('Present', monthData['present'],
                                    Colors.green, screenWidth),
                                _statusWidget('Absent', monthData['absent'],
                                    Colors.red, screenWidth),
                                _statusWidget('Leave', monthData['leave'],
                                    Colors.blue, screenWidth),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusWidget(
      String label, int count, Color color, double screenWidth) {
    return Padding(
      padding: EdgeInsets.only(left: screenWidth * 0.02),
      child: Column(
        children: [
          Text(
            '$count',
            style: TextStyle(
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: screenWidth * 0.03,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }
}

class MonthlyAttendanceScreen extends StatelessWidget {
  final String month;
  final int present;
  final int absent;
  final int leave;

  const MonthlyAttendanceScreen({super.key, 
    required this.month,
    required this.present,
    required this.absent,
    required this.leave,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        title: Text(
          'Attendance - $month',
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          children: [
            _attendanceSummary(screenWidth),
            SizedBox(height: screenWidth * 0.04),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 600 ? 10 : 7, // Adaptive grid
                  mainAxisSpacing: screenWidth * 0.02,
                  crossAxisSpacing: screenWidth * 0.02,
                ),
                itemCount: 30, // Assume 30 days for the month
                itemBuilder: (context, index) {
                  final day = index + 1;
                  final statuses = ['Present', 'Absent', 'Leave'];
                  final status = statuses[index % statuses.length];
                  return Container(
                    decoration: BoxDecoration(
                      color: status == 'Present'
                          ? Colors.green.shade100
                          : status == 'Absent'
                              ? Colors.red.shade100
                              : Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: Colors.grey),
                    ),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '$day',
                          style: TextStyle(
                            fontSize: screenWidth * 0.04,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          status,
                          style: TextStyle(fontSize: screenWidth * 0.03),
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
    );
  }

  Widget _attendanceSummary(double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _statusWidget('Present', present, Colors.green, screenWidth),
        _statusWidget('Absent', absent, Colors.red, screenWidth),
        _statusWidget('Leave', leave, Colors.blue, screenWidth),
      ],
    );
  }

  Widget _statusWidget(
      String label, int count, Color color, double screenWidth) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
            fontSize: screenWidth * 0.05,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: screenWidth * 0.035,
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
