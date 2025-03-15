import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/services/api_services.dart';

class AddHomeworkScreen extends StatefulWidget {
  @override
  _AddHomeworkScreenState createState() => _AddHomeworkScreenState();
}

class _AddHomeworkScreenState extends State<AddHomeworkScreen>
    with TickerProviderStateMixin {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  String? _selectedStandard;
  String? _selectedSubject;
  final ApiService apiService =
      ApiService(); // Ensure apiService is initialized

  final List<String> _standards = [
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

  final Map<String, List<String>> _subjectsByStandard = {
  '1-A': ['Mathematics', 'English'],
  '1-B': ['Mathematics', 'English'],
  '2-A': ['Mathematics', 'Science'],
  '2-B': ['Mathematics', 'Science'],
  '3-A': ['Mathematics', 'English', 'Science'],
  '3-B': ['Mathematics', 'English', 'Science'],
  '4-A': ['Mathematics', 'Science', 'History'],
  '4-B': ['Mathematics', 'Science', 'History'],
  '5-A': ['Mathematics', 'Science', 'English', 'History'],
  '5-B': ['Mathematics', 'Science', 'English', 'History'],
  '6-A': ['Mathematics', 'Science', 'Geography'],
  '6-B': ['Mathematics', 'Science', 'Geography'],
  '7-A': ['Mathematics', 'Science', 'English', 'Geography'],
  '7-B': ['Mathematics', 'Science', 'English', 'Geography'],
  '8-A': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
  '8-B': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
  '9-A': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
  '9-B': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
  '10-A': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
  '10-B': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
  '11': ['Account', 'State', 'OCM', 'Eco', 'English'],
  '12': ['Account', 'State', 'OCM', 'Eco', 'English'],
};
  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitHomework() async {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _selectedDate == null ||
        _selectedStandard == null ||
        _selectedSubject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    try {
      bool success = await apiService.addHomework(
        _selectedStandard!,
        _selectedSubject!,
        _titleController.text, // Include title field
        _descriptionController.text,
        DateFormat('yyyy-MM-dd').format(_selectedDate!),
      );

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Homework added successfully!")),
        );
        _titleController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedDate = null;
          _selectedStandard = null;
          _selectedSubject = null;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to add homework. Try again.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("An error occurred: $e")),
      );
    }
  }

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text("Add Homework",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: ListView(
          children: [
            Text("Class",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedStandard,
              hint: Text('Select Class'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStandard = newValue;
                  _selectedSubject = null;
                });
              },
              items: _standards.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16),
            Text("Subject",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              value: _selectedSubject,
              hint: Text('Select Subject'),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedSubject = newValue;
                });
              },
              items: _selectedStandard != null
                  ? _subjectsByStandard[_selectedStandard!]!
                      .map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList()
                  : [],
            ),
            SizedBox(height: 16),
            Text("Homework Title",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: "Enter homework title",
                filled: true,
                fillColor: Colors.deepPurple[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            Text("Description",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            TextField(
              controller: _descriptionController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Enter description",
                filled: true,
                fillColor: Colors.deepPurple[50],
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            SizedBox(height: 16),
            Text("Due Date",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            GestureDetector(
              onTap: _pickDate,
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.deepPurple[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  _selectedDate == null
                      ? 'Select Due Date'
                      : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _submitHomework,
              child: Text("Add Homework",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
