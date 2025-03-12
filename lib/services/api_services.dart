// import 'dart:convert';
// import 'package:http/http.dart' as http;

// class ApiService {
//   final String baseUrl;

//   ApiService(this.baseUrl);

//   // Attendance
//   Future<void> addAttendance(
//       String studentId, String date, String status) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/attendance'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'studentId': studentId,
//         'date': date,
//         'status': status,
//       }),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to add attendance');
//     }
//   }

//   Future<List<dynamic>> getAttendance() async {
//     final response = await http.get(Uri.parse('$baseUrl/attendance'));

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load attendance');
//     }
//   }

//   // Marksheet
//   Future<void> addMarksheet(String studentId, String subject, int marks) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/marksheet'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'studentId': studentId,
//         'subject': subject,
//         'marks': marks,
//       }),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to add marksheet');
//     }
//   }

//   Future<List<dynamic>> getMarksheet() async {
//     final response = await http.get(Uri.parse('$baseUrl/marksheet'));

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load marksheet');
//     }
//   }

//   // Notice Board
//   Future<void> addNotice(String title, String content) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/notice_board'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'title': title,
//         'content': content,
//         'date': DateTime.now().toString(),
//       }),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to add notice');
//     }
//   }

//   Future<List<dynamic>> getNotices() async {
//     final response = await http.get(Uri.parse('$baseUrl/notice_board'));

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load notices');
//     }
//   }

//   // Homework
//   Future<void> addHomework(String studentId, String subject, String description,
//       String dueDate) async {
//     final response = await http.post(
//       Uri.parse('$baseUrl/homework'),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'studentId': studentId,
//         'subject': subject,
//         'description': description,
//         'dueDate': dueDate,
//       }),
//     );

//     if (response.statusCode != 201) {
//       throw Exception('Failed to add homework');
//     }
//   }

//   Future<List<dynamic>> getHomework() async {
//     final response = await http.get(Uri.parse('$baseUrl/homework'));

//     if (response.statusCode == 200) {
//       return jsonDecode(response.body);
//     } else {
//       throw Exception('Failed to load homework');
//     }
//   }
// }

// // // import 'package:cloud_firestore/cloud_firestore.dart';

// // class FirestoreService {
// //   final FirebaseFirestore _db = FirebaseFirestore.instance;

// //   // Add a student
// //   Future<void> addStudent(
// //       String name, String dob, String phone, String std) async {
// //     await _db.collection('Addstudent').add({
// //       'name': name,
// //       'Date of Birth': dob,
// //       'Phone No': phone,
// //       'standard': std
// //     });
// //   }

// //   // Add attendance
// //   Future<void> addAttendance(String studentId, String date, String status) async {
// //     await _db.collection('attendance').add({
// //       'studentId': studentId,
// //       'date': date,
// //       'status': status,
// //     });
// //   }

// //   // Add homework
// //   Future<void> addHomework(String studentId, String subject, String description, String dueDate) async {
// //     await _db.collection('homework').add({
// //       'studentId': studentId,
// //       'subject': subject,
// //       'description': description,
// //       'dueDate': dueDate,
// //     });
// //   }

// //   // Add marksheet
// //   Future<void> addMarksheet(String studentId, String subject, int marks) async {
// //     await _db.collection('marksheet').add({
// //       'studentId': studentId,
// //       'subject': subject,
// //       'marks': marks,
// //     });
// //   }

// //   // Add notice
// //   Future<void> addNotice(String title, String content) async {
// //     await _db.collection('notices').add({
// //       'title': title,
// //       'content': content,
// //       'date': DateTime.now().toString(),
// //     });
// //   }
// // }
