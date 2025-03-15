// import 'package:flutter/material.dart';
// import 'package:school/dashboard.dart';
// // import 'package:school/fees.dart';
// import 'package:school/principle/dashboard.dart';
// // import 'package:school/teacher/addHomework.dart';
// import 'package:school/teacher/menu.dart';

// void main() => runApp(RoleSelectionApp());

// class RoleSelectionApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Role Selection with Animation',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         fontFamily: 'Roboto',
//       ),
//       home: RoleSelectionScreen(),
//     );
//   }
// }

// class RoleSelectionScreen extends StatelessWidget {
//   final List<Map<String, String>> roles = [
//     {'role': 'Student', 'icon': '🎓'},
//     {'role': 'Teacher', 'icon': '🧑‍🏫'},
//     {'role': 'Principal', 'icon': '👨‍💼'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Select Your Role',
//           style:
//               TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: roles.length,
//               itemBuilder: (context, index) {
//                 final role = roles[index];
//                 return GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       createFadeScaleRoute(SignInScreen(role: role['role']!)),
//                     );
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20)),
//                     elevation: 5,
//                     margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         gradient: LinearGradient(
//                           colors: [
//                             Colors.deepPurple,
//                             Colors.deepPurple,
//                           ],
//                         ),
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Colors.white,
//                             child: Text(
//                               role['icon']!,
//                               style: TextStyle(fontSize: 24),
//                             ),
//                           ),
//                           SizedBox(width: 16),
//                           Text(
//                             role['role']!,
//                             style: TextStyle(
//                               fontSize: 20,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SignInScreen extends StatefulWidget {
//   final String role;

//   const SignInScreen({required this.role});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen>
//     with SingleTickerProviderStateMixin {
//   bool _rememberMe = false;
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 1500),
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void navigateToRoleScreen() {
//     Widget nextScreen;
//     if (widget.role == 'Student') {
//       nextScreen = FirstPage();
//     } else if (widget.role == 'Teacher') {
//       nextScreen = Menu();
//     } else {
//       nextScreen = TeacherDashboard();
//     }

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => nextScreen),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple,
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Stack(
//           children: [
//             Positioned(
//               top: 160,
//               left: 0,
//               right: 0,
//               child: Container(
//                 height: MediaQuery.of(context).size.height * 0.6,
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topRight: Radius.circular(150),
//                     bottomLeft: Radius.circular(150),
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: MediaQuery.of(context).size.height * 0.3,
//               left: 0,
//               right: 0,
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 24.0),
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.all(16.0),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(
//                             "${widget.role} Sign In",
//                             style: TextStyle(
//                               fontSize: 24,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.deepPurple,
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           TextField(
//                             keyboardType: TextInputType.phone,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.mail),
//                               labelText: '${widget.role} Id',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 20),
//                           TextField(
//                             obscureText: true,
//                             decoration: InputDecoration(
//                               prefixIcon: Icon(Icons.lock),
//                               labelText: 'Password',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           SizedBox(height: 10),
//                           // Remember Me Checkbox
//                           Row(
//                             children: [
//                               Checkbox(
//                                 value: _rememberMe,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     _rememberMe = value!;
//                                   });
//                                 },
//                                 activeColor: Colors.deepPurple,
//                               ),
//                               Text(
//                                 "Remember Me",
//                                 style: TextStyle(
//                                   fontSize: 16,
//                                   color: Colors.deepPurple,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 20),
//                           SizedBox(
//                             width: double.infinity,
//                             child: ElevatedButton(
//                               onPressed: navigateToRoleScreen,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.deepPurple,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 padding:
//                                     const EdgeInsets.symmetric(vertical: 16),
//                               ),
//                               child: const Text(
//                                 "Sign In",
//                                 style: TextStyle(
//                                     fontSize: 16, color: Colors.white),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class ForgotPasswordScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text("Forgot Password Screen"),
//       ),
//     );
//   }
// }

// // class HomeScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Center(
// //         child: Text("Home Screen"),
// //       ),
// //     );
// //   }
// // }

// // Function to create a page route with fade and scale transitions
// Route createFadeScaleRoute(Widget page) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(
//           parent: animation,
//           curve: Curves.easeInOut,
//         ),
//       );

//       final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//         CurvedAnimation(
//           parent: animation,
//           curve: Curves.easeInOut,
//         ),
//       );

//       return FadeTransition(
//         opacity: fadeAnimation,
//         child: ScaleTransition(
//           scale: scaleAnimation,
//           child: child,
//         ),
//       );
//     },
//   );
// }

// import 'package:flutter/material.dart';
// // import 'package:school/dashboard.dart';
// import 'package:school/principle/dashboard.dart';
// import 'package:school/registration.dart';
// import 'package:school/teacher/menu.dart';

// void main() => runApp(RoleSelectionApp());

// class RoleSelectionApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Role Selection with Animation',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         fontFamily: 'Roboto',
//       ),
//       home: RoleSelectionScreen(),
//     );
//   }
// }

// class RoleSelectionScreen extends StatelessWidget {
//   final List<Map<String, String>> roles = [
//     {'role': 'Student', 'icon': '🎓'},
//     {'role': 'Teacher', 'icon': '🧑‍🏫'},
//     {'role': 'Principal', 'icon': '👨‍💼'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Select Your Role',
//           style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: roles.length,
//               itemBuilder: (context, index) {
//                 final role = roles[index];
//                 return GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       createFadeScaleRoute(SignInScreen(role: role['role']!)),
//                     );
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     elevation: 5,
//                     margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         gradient: LinearGradient(colors: [Colors.deepPurple, Colors.deepPurple]),
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Colors.white,
//                             child: Text(role['icon']!, style: TextStyle(fontSize: 24)),
//                           ),
//                           SizedBox(width: 16),
//                           Text(
//                             role['role']!,
//                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SignInScreen extends StatefulWidget {
//   final String role;
//   const SignInScreen({required this.role});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin {
//   bool _rememberMe = false;
//   bool _isPasswordVisible = false; // Password visibility toggle
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
//     _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void navigateToRoleScreen() {
//     Widget nextScreen;
//     if (widget.role == 'Student') {
//       nextScreen = StudentRegistrationScreen();
//     } else if (widget.role == 'Teacher') {
//       nextScreen = Menu();
//     } else {
//       nextScreen = TeacherDashboard();
//     }

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => nextScreen),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple,
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 child: Padding(
//                   padding: EdgeInsets.all(25),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "${widget.role} Sign In",
//                         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
//                       ),
//                       SizedBox(height: 20),

//                       // Email Field
//                       TextField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
//                           hintText: "Email",
//                           filled: true,
//                           fillColor: Colors.deepPurple.shade50,
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//                         ),
//                       ),
//                       SizedBox(height: 15),

//                       // Password Field with Visibility Toggle
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: !_isPasswordVisible,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
//                           hintText: "Password",
//                           filled: true,
//                           fillColor: Colors.deepPurple.shade50,
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//                           suffixIcon: IconButton(
//                             icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.deepPurple),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 15),

//                       // Remember Me Checkbox
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: _rememberMe,
//                             onChanged: (value) => setState(() => _rememberMe = value!),
//                             activeColor: Colors.deepPurple,
//                           ),
//                           Text("Remember Me", style: TextStyle(fontSize: 16, color: Colors.deepPurple)),
//                         ],
//                       ),
//                       SizedBox(height: 20),

//                       // Sign In Button
//                       ElevatedButton(
//                         onPressed: navigateToRoleScreen,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                           padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         child: Text("Sign In", style: TextStyle(fontSize: 18, color: Colors.white)),
//                       ),

//                       SizedBox(height: 10),

//                       // Forgot Password Button
//                       TextButton(
//                         onPressed: () {
//                           // Navigate to Forgot Password Screen
//                         },
//                         child: Text("Forgot Password?", style: TextStyle(fontSize: 16, color: Colors.deepPurple)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Function to create a page route with fade and scale transitions
// Route createFadeScaleRoute(Widget page) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//       );

//       final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//         CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//       );

//       return FadeTransition(
//         opacity: fadeAnimation,
//         child: ScaleTransition(scale: scaleAnimation, child: child),
//       );
//     },
//   );
// }



// import 'package:flutter/material.dart';
// import 'package:school/principle/dashboard.dart';
// import 'package:school/registration.dart';
// import 'package:school/teacher/menu.dart';

// void main() => runApp(RoleSelectionApp());

// class RoleSelectionApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Role Selection with Animation',
//       theme: ThemeData(
//         primarySwatch: Colors.deepPurple,
//         fontFamily: 'Roboto',
//       ),
//       home: RoleSelectionScreen(),
//     );
//   }
// }

// class RoleSelectionScreen extends StatelessWidget {
//   final List<Map<String, String>> roles = [
//     {'role': 'Student', 'icon': '🎓'},
//     {'role': 'Teacher', 'icon': '🧑‍🏫'},
//     {'role': 'Principal', 'icon': '👨‍💼'},
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Select Your Role',
//           style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//         elevation: 0,
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: EdgeInsets.all(16),
//               itemCount: roles.length,
//               itemBuilder: (context, index) {
//                 final role = roles[index];
//                 return GestureDetector(
//                   behavior: HitTestBehavior.opaque,
//                   onTap: () {
//                     if (role['role'] == 'Student') {
//                       // ✅ Navigate to Student Registration Page
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => StudentRegistrationScreen()),
//                       );
//                     } else {
//                       // ✅ Navigate to Sign-In Page for other roles
//                       Navigator.push(
//                         context,
//                         createFadeScaleRoute(SignInScreen(role: role['role']!)),
//                       );
//                     }
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                     elevation: 5,
//                     margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         gradient: LinearGradient(colors: [Colors.deepPurple, Colors.deepPurple]),
//                       ),
//                       child: Row(
//                         children: [
//                           CircleAvatar(
//                             radius: 30,
//                             backgroundColor: Colors.white,
//                             child: Text(role['icon']!, style: TextStyle(fontSize: 24)),
//                           ),
//                           SizedBox(width: 16),
//                           Text(
//                             role['role']!,
//                             style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // 🔹 Sign-In Screen (For Teacher & Principal)
// class SignInScreen extends StatefulWidget {
//   final String role;
//   const SignInScreen({required this.role});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin {
//   bool _rememberMe = false;
//   bool _isPasswordVisible = false;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
//     _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void navigateToRoleScreen() {
//     Widget nextScreen;
//     if (widget.role == 'Teacher') {
//       nextScreen = Menu();
//     } else {
//       nextScreen = TeacherDashboard();
//     }

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => nextScreen),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple,
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: EdgeInsets.all(20.0),
//               child: Card(
//                 elevation: 5,
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 child: Padding(
//                   padding: EdgeInsets.all(25),
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         "${widget.role} Sign In",
//                         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
//                       ),
//                       SizedBox(height: 20),

//                       // Email Field
//                       TextField(
//                         controller: _emailController,
//                         keyboardType: TextInputType.emailAddress,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
//                           hintText: "Email",
//                           filled: true,
//                           fillColor: Colors.deepPurple.shade50,
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//                         ),
//                       ),
//                       SizedBox(height: 15),

//                       // Password Field with Visibility Toggle
//                       TextField(
//                         controller: _passwordController,
//                         obscureText: !_isPasswordVisible,
//                         decoration: InputDecoration(
//                           prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
//                           hintText: "Password",
//                           filled: true,
//                           fillColor: Colors.deepPurple.shade50,
//                           border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
//                           suffixIcon: IconButton(
//                             icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.deepPurple),
//                             onPressed: () {
//                               setState(() {
//                                 _isPasswordVisible = !_isPasswordVisible;
//                               });
//                             },
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 15),

//                       // Remember Me Checkbox
//                       Row(
//                         children: [
//                           Checkbox(
//                             value: _rememberMe,
//                             onChanged: (value) => setState(() => _rememberMe = value!),
//                             activeColor: Colors.deepPurple,
//                           ),
//                           Text("Remember Me", style: TextStyle(fontSize: 16, color: Colors.deepPurple)),
//                         ],
//                       ),
//                       SizedBox(height: 20),

//                       // Sign In Button
//                       ElevatedButton(
//                         onPressed: navigateToRoleScreen,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.deepPurple,
//                           padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                         ),
//                         child: Text("Sign In", style: TextStyle(fontSize: 18, color: Colors.white)),
//                       ),

//                       SizedBox(height: 10),

//                       // Forgot Password Button
//                       TextButton(
//                         onPressed: () {
//                           // Navigate to Forgot Password Screen
//                         },
//                         child: Text("Forgot Password?", style: TextStyle(fontSize: 16, color: Colors.deepPurple)),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Function to create a page route with fade and scale transitions
// Route createFadeScaleRoute(Widget page) {
//   return PageRouteBuilder(
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
//         CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//       );

//       final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
//         CurvedAnimation(parent: animation, curve: Curves.easeInOut),
//       );

//       return FadeTransition(
//         opacity: fadeAnimation,
//         child: ScaleTransition(scale: scaleAnimation, child: child),
//       );
//     },
//   );
// }

import 'package:flutter/material.dart';
import 'package:school/principle/dashboard.dart';
import 'package:school/registration.dart';
import 'package:school/teacher/menu.dart';
import 'package:school/services/api_services.dart';

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
          style: TextStyle(color: Colors.deepPurple, fontWeight: FontWeight.bold),
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
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    if (role['role'] == 'Student') {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => StudentRegistrationScreen()));
                    } else {
                      Navigator.push(context, createFadeScaleRoute(SignInScreen(role: role['role']!)));
                    }
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(colors: [Colors.deepPurple, Colors.deepPurple]),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Text(role['icon']!, style: TextStyle(fontSize: 24)),
                          ),
                          SizedBox(width: 16),
                          Text(
                            role['role']!,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                        ],
                      ),
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

// 🔹 Sign-In Screen (For Students, Teachers, Principals)
class SignInScreen extends StatefulWidget {
  final String role;
  const SignInScreen({required this.role});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> with SingleTickerProviderStateMixin {
  bool _rememberMe = false;
  bool _isPasswordVisible = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 1500));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void navigateToRoleScreen() {
    Widget nextScreen;
    if (widget.role == 'Student') {
      nextScreen = StudentRegistrationScreen();
    } else if (widget.role == 'Teacher') {
      nextScreen = Menu();
    } else {
      nextScreen = TeacherDashboard();
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => nextScreen),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: EdgeInsets.all(25),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${widget.role} Sign In",
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      SizedBox(height: 20),

                      // Email Field
                      TextField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email, color: Colors.deepPurple),
                          hintText: "Email",
                          filled: true,
                          fillColor: Colors.deepPurple.shade50,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Password Field with Visibility Toggle
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock, color: Colors.deepPurple),
                          hintText: "Password",
                          filled: true,
                          fillColor: Colors.deepPurple.shade50,
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                          suffixIcon: IconButton(
                            icon: Icon(_isPasswordVisible ? Icons.visibility : Icons.visibility_off, color: Colors.deepPurple),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Remember Me Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) => setState(() => _rememberMe = value!),
                            activeColor: Colors.deepPurple,
                          ),
                          Text("Remember Me", style: TextStyle(fontSize: 16, color: Colors.deepPurple)),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Sign In Button
                      ElevatedButton(
                        onPressed: navigateToRoleScreen,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple,
                          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 40),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        child: Text("Sign In", style: TextStyle(fontSize: 18, color: Colors.white)),
                      ),

                      SizedBox(height: 10),

                      // Forgot Password Button
                      TextButton(
                        onPressed: () {
                          // Navigate to Forgot Password Screen
                        },
                        child: Text("Forgot Password?", style: TextStyle(fontSize: 16, color: Colors.deepPurple)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// 🔹 Smooth Transition Function
Route createFadeScaleRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      );

      final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: Curves.easeInOut),
      );

      return FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(scale: scaleAnimation, child: child),
      );
    },
  );
}
