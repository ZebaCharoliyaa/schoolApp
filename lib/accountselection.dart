// import 'package:flutter/material.dart';
// import 'package:school/dashboard.dart';

// void main() => runApp(RoleSelectionApp());

// class RoleSelectionApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Animated Role Selection',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.deepPurple,
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
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => SignInScreen(role: role['role']!),
//                       ),
//                     );
//                   },
//                   child: AnimatedRoleCard(role: role),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class AnimatedRoleCard extends StatelessWidget {
//   final Map<String, String> role;

//   AnimatedRoleCard({required this.role});

//   @override
//   Widget build(BuildContext context) {
//     return Hero(
//       tag: role['role']!,
//       child: Card(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         elevation: 5,
//         margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
//         child: Container(
//           padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(20),
//             gradient: LinearGradient(
//               colors: [Colors.deepPurple, Colors.deepPurple],
//             ),
//           ),
//           child: Row(
//             children: [
//               CircleAvatar(
//                 radius: 30,
//                 backgroundColor: Colors.white,
//                 child: Text(
//                   role['icon']!,
//                   style: TextStyle(fontSize: 24),
//                 ),
//               ),
//               SizedBox(width: 16),
//               Text(
//                 role['role']!,
//                 style: TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Sign In Screen
// class SignInScreen extends StatefulWidget {
//   final String role;

//   SignInScreen({required this.role});

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       vsync: this,
//       duration: Duration(milliseconds: 800),
//     );
//     _fadeAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
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
//       nextScreen = firstpage();
//     } else if (widget.role == 'Teacher') {
//       nextScreen = TeacherFeesScreen();
//     } else {
//       nextScreen = PrincipalSplashScreen();
//     }

//     Navigator.pushReplacement(
//       context,
//       MaterialPageRoute(builder: (context) => nextScreen),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.deepPurple),
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Hero(
//                 tag: widget.role,
//                 child: Text(
//                   '${widget.role} Sign In',
//                   style: TextStyle(
//                     fontSize: 28,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.deepPurple,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 decoration: InputDecoration(
//                   labelText: 'Username',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.person),
//                 ),
//               ),
//               SizedBox(height: 16),
//               TextField(
//                 obscureText: true,
//                 decoration: InputDecoration(
//                   labelText: 'Password',
//                   border: OutlineInputBorder(),
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//               ),
//               SizedBox(height: 24),
//               ElevatedButton(
//                 onPressed: navigateToRoleScreen,
//                 style: ElevatedButton.styleFrom(
//                   minimumSize: Size(double.infinity, 50),
//                   backgroundColor: Colors.deepPurple,
//                 ),
//                 child: Text(
//                   'Sign In',
//                   style: TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Student Dashboard Screen
// class StudentDashboardScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Student Dashboard")),
//       body: Center(child: Text("Welcome to the Student Dashboard!")),
//     );
//   }
// }

// // Teacher Fees Screen
// class TeacherFeesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Teacher Fees Section")),
//       body: Center(child: Text("Welcome to the Teacher's Fees Section!")),
//     );
//   }
// }

// // Principal Splash Screen
// class PrincipalSplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.deepPurple,
//       body: Center(
//         child: Text(
//           "Welcome, Principal!",
//           style: TextStyle(fontSize: 24, color: Colors.white),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:school/dashboard.dart';
import 'package:school/fees.dart';

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
                    Navigator.push(
                      context,
                      createFadeScaleRoute(SignInScreen(role: role['role']!)),
                    );
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            Colors.deepPurple,
                            Colors.deepPurple,
                          ],
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.white,
                            child: Text(
                              role['icon']!,
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(
                            role['role']!,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
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

class SignInScreen extends StatefulWidget {
  final String role;

  const SignInScreen({required this.role});

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
       bool _rememberMe = false;
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
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
      nextScreen = firstpage();
    } else if (widget.role == 'Teacher') {
      nextScreen = FeesDetailsScreen();
    } else {
      nextScreen = HomeScreen();
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
        child: Stack(
          children: [
            Positioned(
              top: 160,
              left: 0,
              right: 0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(150),
                    bottomLeft: Radius.circular(150),
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.3,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.role} Sign In",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple,
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.mail),
                              labelText: 'Student Id',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.lock),
                              labelText: 'Password',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          // Remember Me Checkbox
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value!;
                                  });
                                },
                                activeColor: Colors.deepPurple,
                              ),
                              Text(
                                "Remember Me",
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.deepPurple,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: navigateToRoleScreen,
                                
                              
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.deepPurple,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                              ),
                              child: const Text(
                                "Sign In",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Forgot Password Screen"),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Home Screen"),
      ),
    );
  }
}

// Function to create a page route with fade and scale transitions
Route createFadeScaleRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
      );

      final scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeInOut,
        ),
      );

      return FadeTransition(
        opacity: fadeAnimation,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: child,
        ),
      );
    },
  );
}
