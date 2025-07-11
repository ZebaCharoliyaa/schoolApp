// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:school/accountselection.dart';
// import 'package:school/homework.dart';
// import 'package:school/dashboard.dart';
// import 'package:school/fees.dart';
// import 'package:school/homework.dart';
// import 'package:school/principle/dashboard.dart';
// import 'package:school/registration.dart';
// import 'package:school/services/auth_service.dart';
// import 'package:school/teacher/menu.dart';
// import 'package:school/dashboard.dart';
// // import 'package:school/signIn.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:school/splash1.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   String? role = await AuthService.getUserRole(); // ✅ Get stored role
//   runApp(MyApp(startScreen: role));
//   try {
//     await Firebase.initializeApp();
//     if (Firebase.apps.isNotEmpty) {
//       print("Firebase Initialized Successfully!");
//       runApp(const MyApp());
//     } else {
//       print("Firebase Initialization Failed!");
//     }
//   } catch (e) {
//     print("Error initializing Firebase: $e");
//   }
//   // runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   final String? startScreen;

//   const MyApp({super.key, this.startScreen});

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: startScreen == 'Student'
//           ? FirstPage()
//           : startScreen == 'Teacher'
//               ? Menu()
//               : startScreen == 'Principal'
//                   ? TeacherDashboard()
//                   : RoleSelectionScreen(),

//       title: 'Flutter Demo',
//       theme: ThemeData(
//         // This is the theme of your application.
//         //
//         // TRY THIS: Try running your application with "flutter run". You'll see
//         // the application has a purple toolbar. Then, without quitting the app,
//         // try changing the seedColor in the colorScheme below to Colors.green
//         // and then invoke "hot reload" (save your changes or press the "hot
//         // reload" button in a Flutter-supported IDE, or press "r" if you used
//         // the command line to start the app).
//         //
//         // Notice that the counter didn't reset back to zero; the application
//         // state is not lost during the reload. To reset the state, use hot
//         // restart instead.
//         //
//         // This works for code too, not just values: Most code changes can be
//         // tested with just a hot reload.
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       // home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       // home: RoleSelectionApp(),
//     );
//   }
// }

// Future<String?> getStoredRole() async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString("user_role"); // ✅ Load role from storage
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

//--------------------without notification-------------------------//
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:school/accountselection.dart';
// import 'package:school/dashboard.dart';
// import 'package:school/principle/dashboard.dart';
// import 'package:school/services/auth_service.dart';
// import 'package:school/teacher/menu.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   try {
//     await Firebase.initializeApp();
//     print("✅ Firebase Initialized Successfully!");

//     String? role =
//         await AuthService.getUserRole(); // 🔍 Get previously saved role
//     print("🔍 Retrieved Role: $role");

//     runApp(MyApp(startScreen: role));
//   } catch (e) {
//     print("❌ Error initializing Firebase: $e");
//   }
// }

// class MyApp extends StatelessWidget {
//   final String? startScreen;

//   const MyApp({super.key, this.startScreen});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'School App',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: _getInitialScreen(),
//     );
//   }

//   Widget _getInitialScreen() {
//     switch (startScreen) {
//       case 'Student':
//         return FirstPage();
//       case 'Teacher':
//         return Menu();
//       case 'Principal':
//         return TeacherDashboard();
//       default:
//         return RoleSelectionScreen(); // First time or after logout
//     }
//   }
// }


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:school/accountselection.dart';
import 'package:school/dashboard.dart';
import 'package:school/principle/dashboard.dart';
import 'package:school/services/auth_service.dart';
import 'package:school/teacher/menu.dart';
import 'package:firebase_database/firebase_database.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// 🔁 Background notifications handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("📩 Background Message: ${message.notification?.title}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    print("✅ Firebase Initialized Successfully!");

    // 🔐 Get user role
    String? role = await AuthService.getUserRole();
    print("🔍 Retrieved Role: $role");

    // 🔔 Save token if student
    await setupFCM(role);

    runApp(MyApp(startScreen: role));
  } catch (e) {
    print("❌ Error initializing Firebase: $e");
    runApp( MaterialApp(home: RoleSelectionScreen()));
  }
}

// 🔔 Save FCM token for student only
Future<void> setupFCM(String? role) async {
  if (role != "Student") return;

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    String? token = await messaging.getToken();
    print("✅ FCM Token: $token");

    final studentId = await AuthService.getStudentId();
    final standard = await AuthService.getStudentStandard();

    if (studentId != null && standard != null && token != null) {
      DatabaseReference ref = FirebaseDatabase.instance.ref();
      await ref.child("students/$standard/$studentId/fcmToken").set(token);
      print("🔄 FCM token saved in DB");
    }
  } else {
    print("🚫 FCM permission not granted");
  }
}

class MyApp extends StatefulWidget {
  final String? startScreen;

  const MyApp({super.key, this.startScreen});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // 🔔 Foreground notification handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('📲 Foreground message received: ${message.notification?.title}');
      if (message.notification != null) {
        showDialog(
          context: navigatorKey.currentContext!,
          builder: (_) => AlertDialog(
            title: Text(message.notification!.title ?? 'Notification'),
            content:
                Text(message.notification!.body ?? 'You have a new message'),
            actions: [
              TextButton(
                child: const Text("OK"),
                onPressed: () =>
                    Navigator.of(navigatorKey.currentContext!).pop(),
              )
            ],
          ),
        );
      }
    });

    // 📨 On notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('📬 Notification opened: ${message.notification?.title}');
      // Optionally navigate to a specific screen
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'School App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: _getInitialScreen(),
    );
  }

  Widget _getInitialScreen() {
    switch (widget.startScreen) {
      case 'Student':
        return FirstPage();
      case 'Teacher':
        return Menu();
      case 'Principal':
        return TeacherDashboard();
      default:
        return  RoleSelectionScreen();
    }
  }
}
