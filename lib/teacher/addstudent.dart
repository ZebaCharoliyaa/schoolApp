
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// // Function to add student to Firestore
// Future<void> addStudent(String name, String age, String grade, String contact, String email) async {
//   await FirebaseFirestore.instance.collection('students').add({
//     'name': name,
//     'age': age,
//     'grade': grade,
//     'contact': contact,
//     'email': email,
//     'createdAt': FieldValue.serverTimestamp(),
//   });
// }

// class AddStudentForm extends StatefulWidget {
//   @override
//   _AddStudentFormState createState() => _AddStudentFormState();
// }

// class _AddStudentFormState extends State<AddStudentForm> {
//   final _formKey = GlobalKey<FormState>();

//   // Form field controllers
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _gradeController = TextEditingController();
//   final TextEditingController _parentContactController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   bool _isSubmitted = false; // Controls button animation
//   DateTime? _selectedBirthDate; // Stores selected birthdate

//   // Function to handle form submission
//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isSubmitted = true;
//       });

//       // // Save data to Firestore
//       // await addStudent(
//       //   _nameController.text,
//       //   _ageController.text,
//       //   _gradeController.text,
//       //   _parentContactController.text,
//       //   _emailController.text,
//       // );
//        try {
//       await addStudent(
//         _nameController.text,
//         _ageController.text,
//         _gradeController.text,
//         _parentContactController.text,
//         _emailController.text,
//       );
//       print("✅ Student added successfully!"); // Debugging

//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Student Added Successfully!')),
//       );
//     } catch (e) {
//       print("❌ Error adding student: $e"); // Debugging
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to add student: $e')),
//       );
//     }

//       // Reset animation after submission
//       Future.delayed(Duration(seconds: 2), () {
//         setState(() {
//           _isSubmitted = false;
//         });
//       });

//       // Show success message
//       // ScaffoldMessenger.of(context).showSnackBar(
//       //   SnackBar(content: Text('Student Added Successfully!')),
//       // );

//       // Clear the formq
//       _nameController.clear();
//       _ageController.clear();
//       _gradeController.clear();
//       _parentContactController.clear();
//       _emailController.clear();
//       setState(() {
//         _selectedBirthDate = null;
//       });
//     }
//   }

//   // Function to fetch students from Firestore
//   Stream<QuerySnapshot> fetchStudent() {
//     return FirebaseFirestore.instance.collection('students').snapshots();
//   }

//   // Function to pick birthdate using DatePicker
//   Future<void> _pickBirthDate() async {
//     DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1900),
//       lastDate: DateTime.now(),
//     );

//     if (pickedDate != null) {
//       setState(() {
//         _selectedBirthDate = pickedDate;
//       });
//       // Calculate age based on birthdate
//       final age = DateTime.now().year - pickedDate.year;
//       _ageController.text = age.toString();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//         ),
//         title: Text('Add Student', style: TextStyle(color: Colors.white)),
//         backgroundColor: Colors.deepPurple,
//       ),
//       body: AnimatedContainer(
//         duration: Duration(milliseconds: 500),
//         color: _isSubmitted ? Colors.green.shade100 : Colors.white,
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: [
//                 // Title
//                 AnimatedDefaultTextStyle(
//                   duration: Duration(milliseconds: 300),
//                   style: TextStyle(
//                     fontSize: _isSubmitted ? 24 : 18,
//                     fontWeight: FontWeight.bold,
//                     color: _isSubmitted ? Colors.green : Colors.black,
//                   ),
//                   child: Text('Add Student Details'),
//                 ),
//                 SizedBox(height: 16),

//                 // Name field
//                 TextFormField(
//                   controller: _nameController,
//                   decoration: InputDecoration(
//                     labelText: 'Student Name',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the student\'s name';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),

//                 // BirthDate field with Date Picker
//                 GestureDetector(
//                   onTap: _pickBirthDate,
//                   child: AbsorbPointer(
//                     child: TextFormField(
//                       controller: TextEditingController(
//                         text: _selectedBirthDate == null
//                             ? 'Select Birthdate'
//                             : DateFormat('dd-MM-yyyy').format(_selectedBirthDate!),
//                       ),
//                       decoration: InputDecoration(
//                         labelText: 'BirthDate',
//                         border: OutlineInputBorder(),
//                       ),
//                       validator: (value) {
//                         if (_selectedBirthDate == null) {
//                           return 'Please select a valid birthdate';
//                         }
//                         return null;
//                       },
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 16),

//                 // Grade field
//                 TextFormField(
//                   controller: _gradeController,
//                   decoration: InputDecoration(
//                     labelText: 'Grade/Class',
//                     border: OutlineInputBorder(),
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the grade/class';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),

//                 // Parent's contact field
//                 TextFormField(
//                   controller: _parentContactController,
//                   decoration: InputDecoration(
//                     labelText: 'Parent\'s Contact Number',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.phone,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the parent\'s contact number';
//                     }
//                     if (!RegExp(r'^\d{10}$').hasMatch(value)) {
//                       return 'Please enter a valid 10-digit phone number';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 16),

//                 // Email field
//                 TextFormField(
//                   controller: _emailController,
//                   decoration: InputDecoration(
//                     labelText: 'Email',
//                     border: OutlineInputBorder(),
//                   ),
//                   keyboardType: TextInputType.emailAddress,
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Please enter the email';
//                     }
//                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
//                       return 'Please enter a valid email address';
//                     }
//                     return null;
//                   },
//                 ),
//                 SizedBox(height: 24),

//                 // Submit button
//                 AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   curve: Curves.easeInOut,
//                   child: ElevatedButton(
//                     onPressed: _submitForm,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: _isSubmitted ? Colors.green : Colors.deepPurple,
//                       padding: EdgeInsets.symmetric(vertical: 16),
//                       textStyle: TextStyle(fontSize: 16),
//                     ),
//                     child: Text(
//                       _isSubmitted ? 'Success!' : 'Add Student',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


        

        import 'package:flutter/material.dart';
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
      firstDate: DateTime(2000),
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
      appBar: AppBar(title: Text('Student Management')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Input Fields
            TextField(controller: nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: dobController, decoration: InputDecoration(labelText: 'Date of Birth')),
            TextField(controller: phoneController, decoration: InputDecoration(labelText: 'Phone Number')),
            TextField(controller: standardController, decoration: InputDecoration(labelText: 'Standard')),

            SizedBox(height: 10),

            // Add Student Button
            ElevatedButton(onPressed: addStudent, child: Text('Add Student')),

            SizedBox(height: 20),

            // Student List
            Expanded(
              child: students.isEmpty
                  ? Center(child: Text('No students found.'))
                  : ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        final student = students[index];
                        return ListTile(
                          title: Text(student['name']),
                          subtitle: Text('DOB: ${student['dob']}, Phone: ${student['phone']}, Std: ${student['standard']}'),
                        );
                      },
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
