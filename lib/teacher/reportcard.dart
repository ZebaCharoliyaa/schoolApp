import 'package:flutter/material.dart';

void main() {
  runApp(ReportCardApp());
}

class ReportCardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Upload Report Card',
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: SelectClassScreen(),
    );
  }
}

class SelectClassScreen extends StatelessWidget {
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
    '11-A',
    '11-B',
    '12-A',
    '12-B'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Class')),
      body: ListView.builder(
        itemCount: standards.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(standards[index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SelectStudentScreen(standards[index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SelectStudentScreen extends StatelessWidget {
  final String standard;
  final Map<String, List<String>> studentsByStandard = {
    '1-A': ['Student A1', 'Student A2'],
    '1-B': ['Student B1', 'Student B2'],
    '2-A': ['Student A3', 'Student A4'],
    '2-B': ['Student B3', 'Student B4'],
    '3-A': ['Student A5', 'Student A6'],
    '12-B': ['Student Z1', 'Student Z2'],
  };

  SelectStudentScreen(this.standard);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Student ($standard)')),
      body: ListView.builder(
        itemCount: studentsByStandard[standard]?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(studentsByStandard[standard]![index]),
            trailing: Icon(Icons.arrow_forward),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      EnterMarksScreen(studentsByStandard[standard]![index]),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class EnterMarksScreen extends StatefulWidget {
  final String studentName;
  EnterMarksScreen(this.studentName);

  @override
  _EnterMarksScreenState createState() => _EnterMarksScreenState();
}

class _EnterMarksScreenState extends State<EnterMarksScreen> {
  final List<String> subjects = ['English', 'Mathematics', 'Science'];
  final Map<String, TextEditingController> marksControllersTerm1 = {};
  final Map<String, TextEditingController> marksControllersTerm2 = {};
  final TextEditingController attendanceDaysController =
      TextEditingController();
  final TextEditingController totalDaysController = TextEditingController();

  @override
  void initState() {
    super.initState();
    subjects.forEach((subject) {
      marksControllersTerm1[subject] = TextEditingController();
      marksControllersTerm2[subject] = TextEditingController();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Enter Marks and Attendance - ${widget.studentName}')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter Marks and Attendance for ${widget.studentName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Table for entering marks
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Subject',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Term 1 Marks',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Term 2 Marks',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ]),
                ...subjects.map((subject) {
                  return TableRow(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(subject),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: marksControllersTerm1[subject],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Term 1 Marks',
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: TextField(
                        controller: marksControllersTerm2[subject],
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'Enter Term 2 Marks',
                        ),
                      ),
                    ),
                  ]);
                }).toList(),
              ],
            ),
            SizedBox(height: 20),

            // Annual Attendance Table for entering attendance
            Text(
              'Enter Annual Attendance Days for ${widget.studentName}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              controller: attendanceDaysController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Days Attended',
                hintText: 'Enter Days Attended',
              ),
            ),
            SizedBox(height: 10),
            TextField(
              controller: totalDaysController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Total Days',
                hintText: 'Enter Total Days of the Year',
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                // Navigate to Report Card screen after entering marks
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReportCardScreen(
                      widget.studentName,
                      marksControllersTerm1,
                      marksControllersTerm2,
                      attendanceDaysController,
                      totalDaysController,
                    ),
                  ),
                );
              },
              child: Text('Generate Report Card'),
            ),
          ],
        ),
      ),
    );
  }
}

class ReportCardScreen extends StatelessWidget {
  final String studentName;
  final Map<String, TextEditingController> marksControllersTerm1;
  final Map<String, TextEditingController> marksControllersTerm2;
  final TextEditingController attendanceDaysController;
  final TextEditingController totalDaysController;

  ReportCardScreen(
      this.studentName,
      this.marksControllersTerm1,
      this.marksControllersTerm2,
      this.attendanceDaysController,
      this.totalDaysController);

  @override
  Widget build(BuildContext context) {
    double totalMarksTerm1 = 0.0;
    double totalMarksTerm2 = 0.0;
    double finalMarks = 0.0;

    // Calculate sum of Term 1, Term 2 marks, and final total marks
    marksControllersTerm1.forEach((subject, controller) {
      totalMarksTerm1 += double.tryParse(controller.text) ?? 0.0;
    });
    marksControllersTerm2.forEach((subject, controller) {
      totalMarksTerm2 += double.tryParse(controller.text) ?? 0.0;
    });

    finalMarks = totalMarksTerm1 + totalMarksTerm2;

    // Calculate the percentage
    double percentage =
        (finalMarks / (marksControllersTerm1.length * 100 * 2)) * 100;

    // Calculate attendance percentage based on the entered days
    double attendancePercentage = 0.0;
    double attendedDays = double.tryParse(attendanceDaysController.text) ?? 0.0;
    double totalDays = double.tryParse(totalDaysController.text) ?? 0.0;

    if (totalDays != 0) {
      attendancePercentage = (attendedDays / totalDays) * 100;
    }

    return Scaffold(
      appBar: AppBar(title: Text('Report Card')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$studentName\'s Report Card',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Report Card Table (Marks)
            Table(
              border: TableBorder.all(),
              children: [
                TableRow(children: [
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Subject',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Term 1 Marks',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Term 2 Marks',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Total Marks',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                ]),
                ...marksControllersTerm1.keys.map((subject) {
                  double term1Marks =
                      double.tryParse(marksControllersTerm1[subject]!.text) ??
                          0.0;
                  double term2Marks =
                      double.tryParse(marksControllersTerm2[subject]!.text) ??
                          0.0;
                  double totalSubjectMarks = term1Marks + term2Marks;

                  return TableRow(children: [
                    Padding(padding: EdgeInsets.all(8.0), child: Text(subject)),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('$term1Marks')),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('$term2Marks')),
                    Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('$totalSubjectMarks')),
                  ]);
                }).toList(),
                TableRow(children: [
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Final Total Marks',
                          style: TextStyle(fontWeight: FontWeight.bold))),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('$totalMarksTerm1')),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('$totalMarksTerm2')),
                  Padding(
                      padding: EdgeInsets.all(8.0), child: Text('$finalMarks')),
                ]),
              ],
            ),

            SizedBox(height: 20),

            // Percentage Summary
            Text(
              'Overall Percentage: ${percentage.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 20),

            // Attendance Summary (Days)
            Text(
              'Annual Attendance: ${attendanceDaysController.text}  out of ${totalDaysController.text} days',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Attendance Percentage: ${attendancePercentage.toStringAsFixed(2)}%',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
