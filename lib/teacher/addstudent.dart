import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Required for formatting the date

void main() {
  runApp(MaterialApp(
    home: AddStudentForm(),
  ));
}

class AddStudentForm extends StatefulWidget {
  @override
  _AddStudentFormState createState() => _AddStudentFormState();
}

class _AddStudentFormState extends State<AddStudentForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _parentContactController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _isSubmitted = false; // To control animation

  // DateTime variable to store the birthdate
  DateTime? _selectedBirthDate;

  // Method to handle form submission
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSubmitted = true;
      });

      // Reset the animation after 2 seconds
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isSubmitted = false;
        });
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student Added Successfully!')),
      );

      // Clear the form
      _nameController.clear();
      _ageController.clear();
      _gradeController.clear();
      _parentContactController.clear();
      _emailController.clear();
    }
  }

  // Function to pick birthdate using DatePicker
  Future<void> _pickBirthDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthDate = pickedDate;
      });
      // Optionally, update the age field based on the selected birthdate
      final age = DateTime.now().year - pickedDate.year;
      _ageController.text = age.toString();
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
        title: Text('Add Student',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.deepPurple,

      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 500),
        color: _isSubmitted ? Colors.green.shade100 : Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Title with animation
                AnimatedDefaultTextStyle(
                  duration: Duration(milliseconds: 300),
                  style: TextStyle(
                    fontSize: _isSubmitted ? 24 : 18,
                    fontWeight: FontWeight.bold,
                    color: _isSubmitted ? Colors.green : Colors.black,
                  ),
                  child: Text('Add Student Details'),
                ),
                SizedBox(height: 16),

                // Name field
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Student Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the student\'s name';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // BirthDate field with Date Picker
                GestureDetector(
                  onTap: _pickBirthDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(
                          text: _selectedBirthDate == null
                              ? 'Select Birthdate'
                              : DateFormat('dd-MM-yyyy')
                                  .format(_selectedBirthDate!)),
                      decoration: InputDecoration(
                        labelText: 'BirthDate',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            _selectedBirthDate == null) {
                          return 'Please select a valid birthdate';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(height: 16),

                // Grade field
                TextFormField(
                  controller: _gradeController,
                  decoration: InputDecoration(
                    labelText: 'Grade/Class',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the grade/class';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Parent's contact field
                TextFormField(
                  controller: _parentContactController,
                  decoration: InputDecoration(
                    labelText: 'Parent\'s Contact Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the parent\'s contact number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16),

                // Email field
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24),

                // Submit button
                AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isSubmitted ? Colors.green : Colors.deepPurple,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      textStyle: TextStyle(fontSize: 16),
                    ),
                    child: Text(
                      _isSubmitted ? 'Success!' : 'Add Student',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
