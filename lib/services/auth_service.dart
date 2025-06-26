// import 'package:shared_preferences/shared_preferences.dart';

// class AuthService {
// // Save role selection flag
//   static Future<void> setRoleSelected(bool selected) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setBool('isRoleSelected', selected);
//   }

// // Get role selection flag
//   static Future<bool> isRoleSelected() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getBool('isRoleSelected') ?? false;
//   }

// // Clear everything on logout
//   static Future<void> logout() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }

//   static Future<void> saveUserRole(String role) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('userRole', role);
//     print("✅ User Role Saved: $role"); // Debugging log
//   }

//   static Future<String?> getUserRole() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? role = prefs.getString('userRole');
//     print("🔍 Retrieved Role: $role"); // Debugging log
//     return role;
//   }

//   // ✅ Save the student's `standardId` in SharedPreferences
//   static Future<void> saveStandardId(String standardId) async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString('standardId', standardId);
//     print("✅ Standard ID saved: $standardId");
//   }

//   // ✅ Get the stored `standardId` from SharedPreferences
//   static Future<String?> getStudentStandardId() async {
//     final prefs = await SharedPreferences.getInstance();
//     String? standardId = prefs.getString('standardId');
//     print("🔍 Retrieved standardId from SharedPreferences: $standardId");
//     return standardId;
//   }
// }










import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();

  // ✅ Save role selection flag
  static Future<void> setRoleSelected(bool selected) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRoleSelected', selected);
  }

  // ✅ Get role selection flag
  static Future<bool> isRoleSelected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isRoleSelected') ?? false;
  }

  // ✅ Clear everything on logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  // ✅ Save user role
  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', role);
    print("✅ User Role Saved: $role");
  }

  // ✅ Get user role
  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('userRole');
    print("🔍 Retrieved Role: $role");
    return role;
  }

  // ✅ Save the student's standardId in SharedPreferences
  static Future<void> saveStandardId(String standardId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('standardId', standardId);
    print("✅ Standard ID saved: $standardId");
  }

  // ✅ Get the stored standardId from SharedPreferences
  static Future<String?> getStudentStandardId() async {
    final prefs = await SharedPreferences.getInstance();
    String? standardId = prefs.getString('standardId');
    print("🔍 Retrieved standardId from SharedPreferences: $standardId");
    return standardId;
  }

  // ✅ Get logged-in student ID from Realtime Database
  static Future<String?> getStudentId() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final snapshot = await _dbRef.child('students').get();
    if (!snapshot.exists) return null;

    final data = snapshot.value as Map;
    for (final standard in data.entries) {
      final students = standard.value as Map;
      for (final student in students.entries) {
        final studentData = student.value as Map;
        if (studentData['email'] == user.email) {
          return student.key; // student ID
        }
      }
    }

    return null;
  }

  // ✅ Get logged-in student Standard from Realtime Database
  static Future<String?> getStudentStandard() async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final snapshot = await _dbRef.child('students').get();
    if (!snapshot.exists) return null;

    final data = snapshot.value as Map;
    for (final standardEntry in data.entries) {
      final standard = standardEntry.key;
      final students = standardEntry.value as Map;

      for (final student in students.entries) {
        final studentData = student.value as Map;
        if (studentData['email'] == user.email) {
          return standard; // e.g., "10-A"
        }
      }
    }

    return null;
  }
}
