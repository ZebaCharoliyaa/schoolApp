import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddHomeworkScreen extends StatefulWidget {
  AddHomeworkScreen({Key? key}) : super(key: key);

  @override
  _AddHomeworkScreenState createState() => _AddHomeworkScreenState();
}

class _AddHomeworkScreenState extends State<AddHomeworkScreen>
    with TickerProviderStateMixin {
  // Controllers for form fields
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  // Variable to store the selected due date
  DateTime? _selectedDate;

  // Dropdown variables for standard and subject selection
  String? _selectedStandard;
  String? _selectedSubject;

  final List<String> _standards = [
    'Class 1',
    'Class 2',
    'Class 3',
    'Class 4',
    'Class 5',
    'Class 6',
    'Class 7',
    'Class 8',
    'Class 9',
    'Class 10',
    'Class 11',
    'Class 12',
  ];

  final Map<String, List<String>> _subjectsByStandard = {
    'Class 1': ['Mathematics', 'English'],
    'Class 2': ['Mathematics', 'Science'],
    'Class 3': ['Mathematics', 'English', 'Science'],
    'Class 4': ['Mathematics', 'Science', 'History'],
    'Class 5': ['Mathematics', 'Science', 'English', 'History'],
    'Class 6': ['Mathematics', 'Science', 'Geography'],
    'Class 7': ['Mathematics', 'Science', 'English', 'Geography'],
    'Class 8': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
    'Class 9': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
    'Class 10': ['Mathematics', 'Science', 'English', 'History', 'Geography'],
    'Class 11': ['Account', 'state', 'ocm', 'eco', 'English'],
    'Class 12': ['Account', 'state', 'ocm', 'eco', 'English'],
  };

  // Animation controllers
  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    // Animation setup
    _animationController = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    // Trigger animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  // Function to handle form submission
  void _submitHomework() {
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

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Homework added successfully!")),
    );

//
    // Clear the form after submission
    _titleController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedDate = null;
      _selectedStandard = null;
      _selectedSubject = null;
    });
  }

  // Function to pick a due date using DatePicker
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text("Add Homework",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        actions: [
          // Dropdown for selecting standard in the AppBar
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: DropdownButton<String>(
              value: _selectedStandard,
              hint: Text('Select Class', style: TextStyle(color: Colors.white)),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedStandard = newValue;
                  _selectedSubject = null; // Reset the selected subject
                });
              },
              items: _standards.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value,
                      style: TextStyle(
                          color: _selectedStandard == value
                              ? Colors.white
                              : Colors.deepPurple)),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      body: SlideTransition(
        position: _slideAnimation,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: ListView(
            children: [
              // Subject Dropdown field
              Text("Subject",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              // SizedBox(height: 8),
              DropdownButton<String>(
                value: _selectedSubject,
                hint: Text('Select Subject'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedSubject = newValue;
                  });
                },
                style: TextStyle(
                  color: Colors.deepPurple,
                ),
                items: _selectedStandard != null
                    ? _subjectsByStandard[_selectedStandard]!
                        .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList()
                    : [],
              ),
              SizedBox(height: 16),

              // Title field
              Text("Homework Title",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: "Enter homework title",
                  filled: true,
                  fillColor: Colors.deepPurple[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Description field
              Text("Description",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: "Enter description",
                  filled: true,
                  fillColor: Colors.deepPurple[50],
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Due Date field with a DatePicker
              Text("Due Date",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              GestureDetector(
                onTap: _pickDate,
                child: Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple[50],
                    borderRadius: BorderRadius.circular(12),
                    // border: Border.all(color: Colors.deepPurple),
                  ),
                  child: Text(
                    DateFormat('dd-MM-yyyy')
                        .format(_selectedDate ?? DateTime.now()),
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Submit Button with a modern design
              AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: 1 + _animationController.value * 0.1,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _submitHomework,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.deepPurple, // Background color
                          padding: EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text("Add Homework",
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
