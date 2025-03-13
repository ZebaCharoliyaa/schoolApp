import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/services/api_services.dart';

class StudentScreen extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final ApiService apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _parentContactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  String? _selectedStandard;
  DateTime? _selectedBirthDate;

  bool _isLoading = false;
  bool _isSubmitted = false;

  final List<String> _standards = [
    '1-A', '1-B', '2-A', '2-B', '3-A', '3-B', '4-A', '4-B',
    '5-A', '5-B', '6-A', '6-B', '7-A', '7-B', '8-A', '8-B', '9-A', '9-B', '10-A', '10-B', '11', '12'
  ];

  Future<void> _pickBirthDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedBirthDate = pickedDate;
      });
    }
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedBirthDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select a valid birthdate')),
      );
      return;
    }

    setState(() => _isLoading = true);

    bool success = await apiService.addStudent(
      _nameController.text,
      DateFormat('yyyy-MM-dd').format(_selectedBirthDate!),
      _parentContactController.text,
      _selectedStandard!,
      email: _emailController.text,
    );

    if (success) {
      setState(() => _isSubmitted = true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student added successfully')),
      );
      _nameController.clear();
      _parentContactController.clear();
      _emailController.clear();
      setState(() {
        _selectedBirthDate = null;
        _selectedStandard = null;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add student')),
      );
    }

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('Add Student', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
      ),
      body: AnimatedContainer(
        duration: Duration(milliseconds: 100),
        // color: _isSubmitted ? Colors.green.shade100 : Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
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
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Student Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter student name' : null,
                ),
                SizedBox(height: 16),
                GestureDetector(
                  onTap: _pickBirthDate,
                  child: AbsorbPointer(
                    child: TextFormField(
                      controller: TextEditingController(
                        text: _selectedBirthDate == null
                            ? 'Select Birthdate'
                            : DateFormat('dd-MM-yyyy').format(_selectedBirthDate!),
                      ),
                      decoration: InputDecoration(
                        labelText: 'BirthDate',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) => _selectedBirthDate == null ? 'Select a birthdate' : null,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedStandard,
                  items: _standards.map((std) {
                    return DropdownMenuItem(value: std, child: Text(std));
                  }).toList(),
                  onChanged: (value) => setState(() => _selectedStandard = value),
                  decoration: InputDecoration(labelText: 'Select Standard', border: OutlineInputBorder()),
                  validator: (value) => value == null ? 'Select a standard' : null,
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _parentContactController,
                  decoration: InputDecoration(
                    labelText: 'Parents Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) return 'Enter parents contact number';
                    // if (!RegExp(r'^\d{10}\$').hasMatch(value)) return 'Enter a valid 10-digit number';
                    return null;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return 'Enter an email';
                    // if (!RegExp(r'^[\w-\.]+@[\w-]+\.[\w]{2,4}\$').hasMatch(value)) return 'Enter a valid email';
                    return null;
                  },
                ),
                SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isSubmitted ? Colors.green : Colors.deepPurple,
                    padding: EdgeInsets.symmetric(vertical: 16),
                    textStyle: TextStyle(fontSize: 16),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(_isSubmitted ? 'Success!' : 'Add Student', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
