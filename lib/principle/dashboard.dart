import 'package:flutter/material.dart';

void main() {
  runApp(TeacherDashboardApp());
}

class TeacherDashboardApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      home: TeacherDashboard(),
    );
  }
}

class TeacherDashboard extends StatelessWidget {
  final List<Map<String, dynamic>> gridItems = [
    {
      'title': 'Add Teacher',
      'icon': Icons.person_add,
      'route': TeacherFormScreen()
    },
    {
      'title': 'Notice Board',
      'icon': Icons.notifications,
      'route': NoticeBoard()
    },
    {'title': 'Show Report', 'icon': Icons.assessment, 'route': ShowReport()},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Admin Dashboard")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.2, // Adjust aspect ratio
          ),
          itemCount: gridItems.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => gridItems[index]['route']),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(gridItems[index]['icon'],
                        size: 50, color: Colors.deepPurple),
                    SizedBox(height: 10),
                    Text(
                      gridItems[index]['title'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Dummy Screens
// class AddTeacher extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: Text("Add Teacher")),
//         body: Center(child: Text("Teacher Form Here")));
//   }
// }

class TeacherFormScreen extends StatefulWidget {
  @override
  _TeacherFormScreenState createState() => _TeacherFormScreenState();
}

class _TeacherFormScreenState extends State<TeacherFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController experienceController = TextEditingController();

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      // Process the form data
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Teacher Added Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Teacher'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => value!.isEmpty ? 'Enter name' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) =>
                    value!.contains('@') ? null : 'Enter a valid email',
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) =>
                    value!.length == 10 ? null : 'Enter a valid phone number',
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: subjectController,
                decoration: InputDecoration(labelText: 'Subject'),
                validator: (value) => value!.isEmpty ? 'Enter subject' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: experienceController,
                decoration: InputDecoration(labelText: 'Experience (Years)'),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value!.isEmpty ? 'Enter experience' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                child: Text('Submit', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoticeBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Notice Board")),
        body: Center(child: Text("Notices Here")));
  }
}

class ShowReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Show Report")),
        body: Center(child: Text("Reports Here")));
  }
}
