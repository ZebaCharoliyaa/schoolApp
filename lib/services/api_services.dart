import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl =
      "https://school-c3c3a-default-rtdb.firebaseio.com"; // Use your Firebase database URL


      // ✅ Register Student
  Future<bool> registerStudent({
    required String name,
    required String dob,
    required String phone,
    required String standard,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/students.json'), // Firebase auto-generates an ID
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'dob': dob,
        'phone': phone,
        'standard': standard,
        'email': email,
        'password': password, // Store password securely (hashed if needed)
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
  }
  
  
  // ✅ Add Student with return value
  Future<bool> addStudent(
      String name, String dob, String phone, String standard,
      {required String email}) async {
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

      List<Map<String, dynamic>> students = [];
      data.forEach((key, value) {
        if (value['standard'] == standard) {
          // Filter by standard
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
      Uri.parse('$baseUrl/attendance/$date/$studentId.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'status': status}),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Failed to add attendance');
    }
  }

  // ✅ Get Attendance
  Future<Map<String, String>> getAttendance(String date) async {
    final response =
        await http.get(Uri.parse('$baseUrl/attendance/$date.json'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) ?? {};
      return Map<String, String>.from(
          data.map((key, value) => MapEntry(key, value['status'])));
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
  Future<bool> addNotice(String title, String content) async {
    final response = await http.post(
      Uri.parse('$baseUrl/notice_board.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        // 'content': content,
        'date': DateTime.now().toIso8601String(),
      }),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true; // Notice successfully added
    } else {
      return false; // Failed to add notice
    }
  }

  Future<List<Map<String, dynamic>>> getNotices() async {
    final response = await http.get(Uri.parse('$baseUrl/notice_board.json'));

    if (response.statusCode == 200) {
      if (response.body == "null" || response.body.isEmpty) {
        print("API Response is null or empty");
        return [];
      }

      final Map<String, dynamic>? data = jsonDecode(response.body);

      if (data == null || data.isEmpty) {
        print("No notices found in the database");
        return [];
      }

      List<Map<String, dynamic>> noticesList = [];

      data.forEach((key, value) {
        noticesList.add({
          'id': key,
          'title':
              value['title'] ?? 'Untitled', // ✅ Default title (Avoids null)
          'date':
              value['date'] ?? 'Unknown date', // ✅ Default date (Avoids null)
        });
      });

      return noticesList;
    } else {
      print(
          'Error: Failed to load notices. Status Code: ${response.statusCode}');
      return [];
    }
  }

//update notice
  Future<bool> updateNotice(String id, String newTitle) async {
    final response = await http.patch(
      Uri.parse(
          '$baseUrl/notice_board/$id.json'), // Ensure correct API endpoint
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'title': newTitle}),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to update notice: ${response.body}');
      return false;
    }
  }

  // delete notice
  Future<bool> deleteNotice(String id) async {
    final response = await http.delete(
      Uri.parse(
          '$baseUrl/notice_board/$id.json'), // Ensure correct API endpoint
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to delete notice: ${response.body}');
      return false;
    }
  }

  // ✅ Add Homework
  Future<bool> addHomework(String standardId, String subject,
      String description, String dueDate, String format) async {
    final response = await http.put(
      Uri.parse('$baseUrl/homework/$standardId/$subject.json'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'description': description,
        'dueDate': dueDate,
      }),
    );

    return response.statusCode == 200 || response.statusCode == 201;
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

  getDailyAttendance(String today) {}

  submitAttendance(String today, Map<String, String> attendance) {}

  getMonthlyAttendance(String selectedMonth) {}
}
