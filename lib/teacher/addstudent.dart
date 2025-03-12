// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'package:flutter/material.dart';
// // import 'package:intl/intl.dart';

// // // import 'package:school/services/api_services.dart'; // Required for formatting the date

// // void addStudent(
// //     String name, String age, String grade, String contact, String email) async {
// //   await FirebaseFirestore.instance.collection('students').add({
// //     'name': name,
// //     'age': age,
// //     'grade': grade,
// //     'Contact': contact,
// //     'Email': email,
// //     'createdAt': FieldValue.serverTimestamp(),
// //   });
// // }

// // class AddStudentForm extends StatefulWidget {
// //   // final FirestoreService firestoreService = FirestoreService();
// //   @override
// //   _AddStudentFormState createState() => _AddStudentFormState();
// // }

// // class _AddStudentFormState extends State<AddStudentForm> {
// //   final _formKey = GlobalKey<FormState>();

// //   // Form field controllers
// //   final TextEditingController _nameController = TextEditingController();
// //   final TextEditingController _ageController = TextEditingController();
// //   final TextEditingController _gradeController = TextEditingController();
// //   final TextEditingController _parentContactController =
// //       TextEditingController();
// //   final TextEditingController _emailController = TextEditingController();

// //   bool _isSubmitted = false; // To control animation

// //   // DateTime variable to store the birthdate
// //   DateTime? _selectedBirthDate;

// //   // Method to handle form submission
// //   void _submitForm() {
// //     if (_formKey.currentState!.validate()) {
// //       setState(() {
// //         _isSubmitted = true;
// //       });

// //       // Reset the animation after 2 seconds
// //       Future.delayed(Duration(seconds: 2), () {
// //         setState(() {
// //           _isSubmitted = false;
// //         });
// //       });

// //       ScaffoldMessenger.of(context).showSnackBar(
// //         SnackBar(content: Text('Student Added Successfully!')),
// //       );

// //       // Clear the form
// //       _nameController.clear();
// //       _ageController.clear();
// //       _gradeController.clear();
// //       _parentContactController.clear();
// //       _emailController.clear();
// //     }
// //   }

// //   Stream<QuerySnapshot> fetchStudent() {
// //     return FirebaseFirestore.instance
// //         .collection('students')
// //         .snapshots();
// //   }

// //   // Function to pick birthdate using DatePicker
// //   Future<void> _pickBirthDate() async {
// //     DateTime? pickedDate = await showDatePicker(
// //       context: context,
// //       initialDate: DateTime.now(),
// //       firstDate: DateTime(1900),
// //       lastDate: DateTime.now(),
// //     );

// //     if (pickedDate != null) {
// //       setState(() {
// //         _selectedBirthDate = pickedDate;
// //       });
// //       // Optionally, update the age field based on the selected birthdate
// //       final age = DateTime.now().year - pickedDate.year;
// //       _ageController.text = age.toString();
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.pop(context);
// //           },
// //           icon: Icon(
// //             Icons.arrow_back,
// //             color: Colors.white,
// //           ),
// //         ),
// //         title: Text(
// //           'Add Student',
// //           style: TextStyle(color: Colors.white),
// //         ),
// //         backgroundColor: Colors.deepPurple,
// //       ),
// //       body: AnimatedContainer(
// //         duration: Duration(milliseconds: 500),
// //         color: _isSubmitted ? Colors.green.shade100 : Colors.white,
// //         padding: const EdgeInsets.all(16.0),
// //         child: Form(
// //           key: _formKey,
// //           child: SingleChildScrollView(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.stretch,
// //               children: [
// //                 // Title with animation
// //                 AnimatedDefaultTextStyle(
// //                   duration: Duration(milliseconds: 300),
// //                   style: TextStyle(
// //                     fontSize: _isSubmitted ? 24 : 18,
// //                     fontWeight: FontWeight.bold,
// //                     color: _isSubmitted ? Colors.green : Colors.black,
// //                   ),
// //                   child: Text('Add Student Details'),
// //                 ),
// //                 SizedBox(height: 16),

// //                 // Name field
// //                 TextFormField(
// //                   controller: _nameController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Student Name',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter the student\'s name';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 16),

// //                 // BirthDate field with Date Picker
// //                 GestureDetector(
// //                   onTap: _pickBirthDate,
// //                   child: AbsorbPointer(
// //                     child: TextFormField(
// //                       controller: TextEditingController(
// //                           text: _selectedBirthDate == null
// //                               ? 'Select Birthdate'
// //                               : DateFormat('dd-MM-yyyy')
// //                                   .format(_selectedBirthDate!)),
// //                       decoration: InputDecoration(
// //                         labelText: 'BirthDate',
// //                         border: OutlineInputBorder(),
// //                       ),
// //                       validator: (value) {
// //                         if (value == null ||
// //                             value.isEmpty ||
// //                             _selectedBirthDate == null) {
// //                           return 'Please select a valid birthdate';
// //                         }
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                 ),
// //                 SizedBox(height: 16),

// //                 // Grade field
// //                 TextFormField(
// //                   controller: _gradeController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Grade/Class',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter the grade/class';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 16),

// //                 // Parent's contact field
// //                 TextFormField(
// //                   controller: _parentContactController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Parent\'s Contact Number',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   keyboardType: TextInputType.phone,
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter the parent\'s contact number';
// //                     }
// //                     if (!RegExp(r'^\d{10}$').hasMatch(value)) {
// //                       return 'Please enter a valid 10-digit phone number';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 16),

// //                 // Email field
// //                 TextFormField(
// //                   controller: _emailController,
// //                   decoration: InputDecoration(
// //                     labelText: 'Email',
// //                     border: OutlineInputBorder(),
// //                   ),
// //                   keyboardType: TextInputType.emailAddress,
// //                   validator: (value) {
// //                     if (value == null || value.isEmpty) {
// //                       return 'Please enter the email';
// //                     }
// //                     if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$')
// //                         .hasMatch(value)) {
// //                       return 'Please enter a valid email address';
// //                     }
// //                     return null;
// //                   },
// //                 ),
// //                 SizedBox(height: 24),

// //                 // Submit button
// //                 AnimatedContainer(
// //                   duration: Duration(milliseconds: 300),
// //                   curve: Curves.easeInOut,
// //                   child: ElevatedButton(
// //                     onPressed: _submitForm,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor:
// //                           _isSubmitted ? Colors.green : Colors.deepPurple,
// //                       padding: EdgeInsets.symmetric(vertical: 16),
// //                       textStyle: TextStyle(fontSize: 16),
// //                     ),
// //                     child: Text(
// //                       _isSubmitted ? 'Success!' : 'Add Student',
// //                       style: TextStyle(color: Colors.white),
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

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


//new code realtime dtabase ...

// import 'package:firebase_database/firebase_database.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

// // Function to add student to Realtime Database
// Future<void> addStudent(String name, String age, String grade, String contact, String email) async {
//   DatabaseReference ref = FirebaseDatabase.instance.ref("students").push();
//   await ref.set({
//     'name': name,
//     'age': age,
//     'grade': grade,
//     'contact': contact,
//     'email': email,
//     'createdAt': DateTime.now().toIso8601String(),
//   });
// }

// // Function to fetch students **once** (temporary fetch)
// Future<DataSnapshot> fetchStudentsOnce() async {
//   DatabaseReference ref = FirebaseDatabase.instance.ref("students");
//   return await ref.get();
// }

// class AddStudentForm extends StatefulWidget {
//   @override
//   _AddStudentFormState createState() => _AddStudentFormState();
// }

// class _AddStudentFormState extends State<AddStudentForm> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers for form fields
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _ageController = TextEditingController();
//   final TextEditingController _gradeController = TextEditingController();
//   final TextEditingController _parentContactController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();

//   bool _isSubmitted = false; // Button animation control
//   DateTime? _selectedBirthDate; // Stores selected birthdate
//   List<Map<String, dynamic>> _students = []; // Temporary student list

//   // Function to handle form submission
//   Future<void> _submitForm() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isSubmitted = true;
//       });

//       try {
//         await addStudent(
//           _nameController.text,
//           _ageController.text,
//           _gradeController.text,
//           _parentContactController.text,
//           _emailController.text,
//         );

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Student Added Successfully!')),
//         );

//         // Fetch updated students list after submission (Temporary Fetch)
//         _fetchStudentsTemporary();
//       } catch (e) {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Failed to add student: $e')),
//         );
//       }

//       // Reset animation
//       Future.delayed(Duration(seconds: 2), () {
//         setState(() {
//           _isSubmitted = false;
//         });
//       });

//       // Clear form
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

//   // Fetch students once and store locally
//   Future<void> _fetchStudentsTemporary() async {
//     DataSnapshot snapshot = await fetchStudentsOnce();
//     if (snapshot.value != null) {
//       Map<dynamic, dynamic> studentsMap = snapshot.value as Map<dynamic, dynamic>;
//       List<Map<String, dynamic>> studentsList = studentsMap.entries.map((entry) {
//         return {
//           'key': entry.key,
//           'name': entry.value['name'],
//           'grade': entry.value['grade'],
//         };
//       }).toList();

//       setState(() {
//         _students = studentsList;
//       });
//     } else {
//       setState(() {
//         _students = [];
//       });
//     }
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
//   void initState() {
//     super.initState();
//     _fetchStudentsTemporary(); // Fetch students when screen loads
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
//       body: Column(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Form(
//                 key: _formKey,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.stretch,
//                     children: [
//                       Text('Add Student Details', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 16),

//                       // Name field
//                       TextFormField(
//                         controller: _nameController,
//                         decoration: InputDecoration(
//                           labelText: 'Student Name',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the student\'s name';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 16),

//                       // BirthDate field with Date Picker
//                       GestureDetector(
//                         onTap: _pickBirthDate,
//                         child: AbsorbPointer(
//                           child: TextFormField(
//                             controller: TextEditingController(
//                               text: _selectedBirthDate == null
//                                   ? 'Select Birthdate'
//                                   : DateFormat('dd-MM-yyyy').format(_selectedBirthDate!),
//                             ),
//                             decoration: InputDecoration(
//                               labelText: 'BirthDate',
//                               border: OutlineInputBorder(),
//                             ),
//                             validator: (value) {
//                               if (_selectedBirthDate == null) {
//                                 return 'Please select a valid birthdate';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 16),

//                       // Grade field
//                       TextFormField(
//                         controller: _gradeController,
//                         decoration: InputDecoration(
//                           labelText: 'Grade/Class',
//                           border: OutlineInputBorder(),
//                         ),
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the grade/class';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 16),

//                       // Parent's contact field
//                       TextFormField(
//                         controller: _parentContactController,
//                         decoration: InputDecoration(
//                           labelText: 'Parent\'s Contact Number',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.phone,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the parent\'s contact number';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 16),

//                       // Email field
//                       TextFormField(
//                         controller: _emailController,
//                         decoration: InputDecoration(
//                           labelText: 'Email',
//                           border: OutlineInputBorder(),
//                         ),
//                         keyboardType: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter the email';
//                           }
//                           return null;
//                         },
//                       ),
//                       SizedBox(height: 24),

//                       // Submit button
//                       ElevatedButton(
//                         onPressed: _submitForm,
//                         child: _isSubmitted ? CircularProgressIndicator() : Text('Add Student'),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           // Display Fetched Student List (Temporary Fetch)
//           Expanded(
//             child: _students.isEmpty
//                 ? Center(child: Text("No Students Found"))
//                 : ListView.builder(
//                     itemCount: _students.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         title: Text(_students[index]['name']),
//                         subtitle: Text("Grade: ${_students[index]['grade']}"),
//                       );
//                     },
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }

        

        import 'package:flutter/material.dart';
import 'package:school/services/api_services.dart';
// import 'package:your_project/api_service.dart'; // Ensure you import your ApiService file

class StudentScreen extends StatefulWidget {
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// // Function to add student to Firestore
// Future<void> addStudent(
//     String name, String age, String grade, String contact, String email) async {
//   await FirebaseFirestore.instance.collection('students').add({
//     'name': name,
//     'age': age,
//     'grade': grade,
//     'contact': contact,
//     'email': email,
//     'createdAt': FieldValue.serverTimestamp(),
//   });
// }
// Function to add student to Firestore
Future<void> addStudent(String name, int age, String grade, String contact,
    String email, DateTime birthDate) async {
  await FirebaseFirestore.instance.collection('students').add({
    'name': name,
    'age': age,
    'grade': grade,
    'contact': contact,
    'email': email,
    'birthdate': DateFormat('yyyy-MM-dd')
        .format(birthDate), // Store as a formatted string
    'createdAt': FieldValue.serverTimestamp(),
  });
}

class AddStudentForm extends StatefulWidget {
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _AddStudentFormState extends State<AddStudentForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _parentContactController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Fetch students from Firebase
  Future<void> fetchStudents() async {
    try {
      final fetchedStudents = await apiService.getStudents();
      setState(() {
        _isSubmitted = true;
      });

      // // Save data to Firestore
      // await addStudent(
      //   _nameController.text,
      //   _ageController.text,
      //   _gradeController.text,
      //   _parentContactController.text,
      //   _emailController.text,
      // );
       try {
      await addStudent(
        _nameController.text,
        _ageController.text,
        _gradeController.text,
        _parentContactController.text,
        _emailController.text,
      );
      print("✅ Student added successfully!"); // Debugging

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Student Added Successfully!')),
      );
    } catch (e) {
      print("❌ Error adding student: $e"); // Debugging
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add student: $e')),
      );
    }

      // Reset animation after submission
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _isSubmitted = false;
        });
      });

      // Show success message
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('Student Added Successfully!')),
      // );

      // Clear the formq
      _nameController.clear();
      _ageController.clear();
      _gradeController.clear();
      _parentContactController.clear();
      _emailController.clear();
      setState(() {
        _selectedBirthDate = null;
      });
    }
  }

  // Function to fetch students from Firestore
  Stream<QuerySnapshot> fetchStudent() {
    return FirebaseFirestore.instance.collection('students').snapshots();
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
      // Calculate age based on birthdate
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
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        title: Text('Add Student', style: TextStyle(color: Colors.white)),
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
                // Title
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
                            : DateFormat('dd-MM-yyyy').format(_selectedBirthDate!),
                      ),
                      decoration: InputDecoration(
                        labelText: 'BirthDate',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (_selectedBirthDate == null) {
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
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
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
                      backgroundColor: _isSubmitted ? Colors.green : Colors.deepPurple,
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
