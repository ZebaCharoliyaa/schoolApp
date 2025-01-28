import 'package:flutter/material.dart';
import 'package:school/splash2.dart';
// import 'package:school/exam.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Splash1(),
    );
  }
}

class Splash1 extends StatefulWidget {
  const Splash1({super.key});

  @override
  _Splash1State createState() => _Splash1State();
}

class _Splash1State extends State<Splash1> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white, // Light orange background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Text widget
            const Text(
              "Mark Homework \n as completed",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // Animated Image widget
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/splash1.jpg', // Ensure the file is named correctly
                width: 300,
                height: 300,
              ),
            ),
            const SizedBox(height: 30),
            // Button with animation
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(_createRoute());
              },
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                padding: const EdgeInsets.all(20),
                backgroundColor: Colors.deepPurple,
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to create a custom page route with animation
  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => const Splash2(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // Slide in from the right
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    );
  }
}
//             // Button
//             ElevatedButton(
//               onPressed: () {
//                 // Add action for the button here
//               },
//               style: ElevatedButton.styleFrom(
//                 shape: CircleBorder(),
//                 padding: EdgeInsets.all(20),
//                 backgroundColor: Colors.purple,
//               ),
//               child: Icon(
//                 Icons.arrow_forward_ios,
//                 color: Colors.white,
//                 size: 24,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }