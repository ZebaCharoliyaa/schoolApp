import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "https://school-c3c3a-default-rtdb.firebaseio.com"; // Use your Firebase database URL

  // ✅ Add Student with return value
Future<bool> addStudent(String name, String dob, String phone, String standard, {required String email}) async {
  final response = await http.post(
    Uri.parse('$baseUrl/students.json'), // Firebase auto-generates an ID
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'name': name,
      'dob': dob,
      'phone': phone,
      'standard': standard,
      'email': email
    }),
  );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true; // Success ✅
    } else {
      return false; // Failure ❌
    }
  }

// ✅ Get Students
  Future<List<Map<String, dynamic>>> getStudents(String standard) async {
    final response = await http.get(Uri.parse('$baseUrl/students.json'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data == null) return []; // Return empty list if no students exist

    // List<Map<String, dynamic>> students = [];
    // data.forEach((key, value) {
    //   students.add({
    //     'id': key, // Firebase-generated unique ID
    //     'name': value['name'],
    //     'dob': value['dob'],
    //     'phone': value['phone'],
    //     'standard': value['standard'],
    //     'email': value['email'],
    //   });
    // });

     List<Map<String, dynamic>> students = [];
    data.forEach((key, value) {
      if (value['standard'] == standard) { // Filter by standard
        students.add({
          'id': key,
          'name': value['name'],
          'dob': value['dob'],
          'phone': value['phone'],
          'standard': value['standard'],
          'email': value['email'],
        });
      }
    });

      return students;
    } else {
      throw Exception('Failed to load students');
    }
  }

  // ✅ Add Attendance
  Future<void> addAttendance(
      String studentId, String date, String status) async {
    final response = await http.put(
      Uri.parse('$baseUrl/attendance/$studentId/$date.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add attendance');
    }
  }

  // ✅ Get Attendance
  Future<Map<String, dynamic>?> getAttendance() async {
    final response = await http.get(Uri.parse('$baseUrl/attendance.json'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load attendance');
    }
  }

  // ✅ Add Marksheet
  Future<void> addMarksheet(String studentId, String subject, int marks) async {
    final response = await http.put(
      Uri.parse('$baseUrl/marksheet/$studentId/$subject.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'marks': marks}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add marksheet');
    }
  }

  // ✅ Get Marksheet
  Future<Map<String, dynamic>?> getMarksheet() async {
    final response = await http.get(Uri.parse('$baseUrl/marksheet.json'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load marksheet');
    }
  }

  // ✅ Add Notice
  Future<void> addNotice(String title, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notice_board.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'content': content,
        'date': DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add notice');
    }
  }

  // ✅ Get Notices
  Future<Map<String, dynamic>?> getNotices() async {
    final response = await http.get(Uri.parse('$baseUrl/notice_board.json'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load notices');
    }
  }

  // ✅ Add Homework
  Future<void> addHomework(String studentId, String subject, String description,
      String dueDate) async {
    final response = await http.put(
      Uri.parse('$baseUrl/homework/$studentId/$subject.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'description': description,
        'dueDate': dueDate,
      }),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add homework');
    }
  }

  // ✅ Get Homework
  Future<Map<String, dynamic>?> getHomework() async {
    final response = await http.get(Uri.parse('$baseUrl/homework.json'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load homework');
    }
  }

  static fetchStudents(String standard) {}
}
