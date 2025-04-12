import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
// Save role selection flag
  static Future<void> setRoleSelected(bool selected) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isRoleSelected', selected);
  }

// Get role selection flag
  static Future<bool> isRoleSelected() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isRoleSelected') ?? false;
  }

// Clear everything on logout
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> saveUserRole(String role) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('userRole', role);
    print("✅ User Role Saved: $role"); // Debugging log
  }

  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    String? role = prefs.getString('userRole');
    print("🔍 Retrieved Role: $role"); // Debugging log
    return role;
  }

  // ✅ Save the student's `standardId` in SharedPreferences
  static Future<void> saveStandardId(String standardId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('standardId', standardId);
    print("✅ Standard ID saved: $standardId");
  }

  // ✅ Get the stored `standardId` from SharedPreferences
  static Future<String?> getStudentStandardId() async {
    final prefs = await SharedPreferences.getInstance();
    String? standardId = prefs.getString('standardId');
    print("🔍 Retrieved standardId from SharedPreferences: $standardId");
    return standardId;
  }
}
