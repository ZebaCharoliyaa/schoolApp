import 'package:flutter/material.dart';
import 'package:school/dashboard.dart';
import 'package:school/principle/dashboard.dart';
import 'package:school/registration.dart';
import 'package:school/services/auth_service.dart';
import 'package:school/teacher/menu.dart';
import 'package:school/services/api_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(RoleSelectionApp());

class RoleSelectionApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Role Selection with Animation',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        fontFamily: 'Roboto',
      ),
      home: RoleSelectionScreen(),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  final List<Map<String, String>> roles = [
    {'role': 'Student', 'icon': '🎓'},
    {'role': 'Teacher', 'icon': '🧑‍🏫'},
    {'role': 'Principal', 'icon': '👨‍💼'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Select Your Role',
          style:
              TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: roles.length,
              itemBuilder: (context, index) {
                final role = roles[index];
                return GestureDetector(
                  onTap: () {
                    if (role['role'] == 'Student') {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  StudentRegistrationScreen()));
                    } else {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  SignInScreen(role: role['role']!)));
                    }
                  },
                  child: Card(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    elevation: 5,
                    child: ListTile(
                      leading:
                          Text(role['icon']!, style: TextStyle(fontSize: 30)),
                      title: Text(role['role']!,
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ✅ Sign-In Screen
class SignInScreen extends StatefulWidget {
  final String role;
  const SignInScreen({required this.role});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Widget navigateToDashboard(String role) {
    if (role == 'Student') return FirstPage();
    if (role == 'Teacher') return Menu();
    if (role == 'Principal') return TeacherDashboard();
    return RoleSelectionScreen(); // Default screen if unknown role
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void handleSignIn() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("user_role", widget.role); // ✅ Save role
    print("✅ Role Saved: ${widget.role}");
    // navigateToRoleScreen(widget.role);
    navigateToDashboard(widget.role);
  }

  void navigateToRoleScreen() async {
    print("🔄 Checking User Role Before Saving...");

    if (widget.role.trim().isEmpty) {
      print("❌ Empty role passed. Aborting navigation.");
      return;
    }

    // 🔧 Normalize role to first letter capital (like: Student, Teacher)
    String normalizedRole = widget.role.trim().toLowerCase();
    normalizedRole =
        normalizedRole[0].toUpperCase() + normalizedRole.substring(1);

    await AuthService.saveUserRole(normalizedRole); // ✅ Save normalized role

    String? userRole =
        await AuthService.getUserRole(); // ✅ Retrieve stored role

    print("✅ Retrieved Role: $userRole");

    // 🚀 Ensure correct dashboard navigation
    Widget nextScreen;
    if (userRole == 'Student') {
      nextScreen = FirstPage(); // 🎓 Student Dashboard
    } else if (userRole == 'Teacher') {
      nextScreen = Menu(); // 🧑‍🏫 Teacher Dashboard
    } else if (userRole == 'Principal') {
      nextScreen = TeacherDashboard(); // 👨‍💼 Principal Dashboard
    } else {
      print("❌ Unknown role, staying on login screen.");
      return;
    }

    print("🚀 Navigating to: $userRole Dashboard");

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Card(
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("${widget.role} Sign In",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple)),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                      hintText: "Enter ID",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                  SizedBox(height: 15),
                  TextField(
                    controller: _passwordController,
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                      hintText: "Password",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      suffixIcon: IconButton(
                        icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.deepPurple),
                        onPressed: () => setState(
                            () => _isPasswordVisible = !_isPasswordVisible),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: navigateToRoleScreen,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple),
                    child: Text("Sign In",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                  TextButton(
                      onPressed: () {},
                      child: Text("Forgot Password?",
                          style: TextStyle(
                              fontSize: 16, color: Colors.deepPurple))),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
