import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school/accountselection.dart';
import 'package:school/dashboard.dart';
import 'package:school/services/api_services.dart';

class StudentRegistrationScreen extends StatefulWidget {
  @override
  _StudentRegistrationScreenState createState() =>
      _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final ApiService apiService = ApiService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? _selectedStandard;
  DateTime? _selectedDate;
  bool _rememberMe = false;
  bool _isPasswordVisible = false; // Toggle password visibility

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

  void _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
      });
    }
  }

  void _registerStudent() async {
    if (_nameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _phoneController.text.isEmpty ||
        _passwordController.text.isEmpty ||
        _selectedStandard == null ||
        _selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please fill in all fields")),
      );
      return;
    }

    bool success = await apiService.registerStudent(
      name: _nameController.text,
      dob: DateFormat('dd-MM-yyyy').format(_selectedDate!),
      phone: _phoneController.text,
      standard: _selectedStandard!,
      email: _emailController.text,
      password: _passwordController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? "Registration Successful!"
            : "Registration Failed! Try again."),
      ),
    );

    if (success)
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SignInScreen(
              role: 'student',
            ),
          ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: EdgeInsets.all(25),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Student Registration",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                      ),
                    ),
                    SizedBox(height: 20),

                    // Full Name Field
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.person, color: Colors.deepPurple),
                        hintText: "Full Name",
                        filled: true,
                        fillColor: Colors.deepPurple.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Email Field
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                        hintText: "Email",
                        filled: true,
                        fillColor: Colors.deepPurple.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Phone Number Field
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.phone, color: Colors.deepPurple),
                        hintText: "Phone Number",
                        filled: true,
                        fillColor: Colors.deepPurple.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Password Field
                    TextField(
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                        hintText: "Password",
                        filled: true,
                        fillColor: Colors.deepPurple.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple,
                          ),
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 15),

                    // Standard Selection Dropdown
                    DropdownButtonFormField<String>(
                      value: _selectedStandard,
                      decoration: InputDecoration(
                        prefixIcon:
                            Icon(Icons.school, color: Colors.deepPurple),
                        hintText: "Select Standard",
                        filled: true,
                        fillColor: Colors.deepPurple.shade50,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() => _selectedStandard = newValue);
                      },
                      items: _standards.map((String value) {
                        return DropdownMenuItem(
                            value: value, child: Text(value));
                      }).toList(),
                    ),
                    SizedBox(height: 15),

                    // Date Picker for DOB
                    GestureDetector(
                      onTap: _pickDate,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.calendar_today,
                              color: Colors.deepPurple),
                          hintText: "Date of Birth",
                          filled: true,
                          fillColor: Colors.deepPurple.shade50,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        child: Text(
                          _selectedDate == null
                              ? "Select Date"
                              : DateFormat('dd-MM-yyyy').format(_selectedDate!),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Register Button
                    ElevatedButton(
                      onPressed: _registerStudent,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding:
                            EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      child: Text("Register",
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ),
                    SizedBox(height: 10),

                    // Already Have an Account? Go to Sign In
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignInScreen(role: 'Student')));
                      },
                      child: Text("Already have an account? Sign In",
                          style: TextStyle(
                              fontSize: 16, color: Colors.deepPurple)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
