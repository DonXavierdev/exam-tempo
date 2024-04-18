import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'student_dashboard.dart';
import 'teacher_dashboard.dart';
import 'dart:convert';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unified Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(
          bodyText1: TextStyle(fontFamily: 'Raleway'),
          bodyText2: TextStyle(fontFamily: 'Raleway'),
          headline6: TextStyle(fontFamily: 'Raleway'),
          subtitle1: TextStyle(fontFamily: 'Raleway'),
          subtitle2: TextStyle(fontFamily: 'Raleway'),
          caption: TextStyle(fontFamily: 'Raleway'),
          button: TextStyle(fontFamily: 'Raleway'),
          overline: TextStyle(fontFamily: 'Raleway'),
        ),
      ),
      debugShowCheckedModeBanner: false, // Remove debug banner
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser(BuildContext context) async {
  final String username = usernameController.text;
  final String password = passwordController.text;

  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/login/'),
    body: {'username': username, 'password': password},
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> data = json.decode(response.body);
    String userType = data['user_type'];
    String userName = data['name'];
    String userPrn = data['prn'];
    String userDept = data['department'];
    List<String> userNotify = List<String>.from(data['notification']); 
    List<Map<String, dynamic>> userAlloc = []; // Change to list of maps
    if (userType == 'Student') {
      userAlloc = List<Map<String, dynamic>>.from(data['student_allocations']); // Access list directly
    }
    else{
      userAlloc = List<Map<String, dynamic>>.from(data['teacher_allocations']);
    }
    if (userType == 'Teacher') {
     Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TeacherDashboard(
            userType: userType,
            userDept: userDept,
            userName: userName,
            userPrn: userPrn,
            userNotify : userNotify , 
            userAlloc : userAlloc, 
        ),
        ),
      );
    } else if (userType == 'Student') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StudentDashboard(
            userType: userType,
            userDept: userDept,
            userName: userName,
            userPrn: userPrn,
            userNotify : userNotify , 
            userAlloc: userAlloc,
        ),
        ),
      );
    }
    } 
  else {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Invalid username or password'),
    ));
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Exam Dashboard',
          style: TextStyle(fontSize: 15), // Adjust title text size
        ),
        actions: const [],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Logo
                    Image.asset(
                      'assets/logo.png', // Replace 'logo.png' with your actual image asset path
                      width: 150, // Adjust width as needed
                      height: 150, // Adjust height as needed
                    ),
                    const SizedBox(width: 10), // Add some space between logo and text
                    const Text(
                      'Sign In to access your dashboard',
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.clip,
                    ),
                    const SizedBox(height: 40),
                    TextFormField(
                      controller: usernameController,
                      style: const TextStyle(fontSize: 16),
                      decoration: const InputDecoration(
                        labelText: 'User ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'User ID is Your Student number or Staff ID',
                      style: TextStyle(fontSize: 10, color: Colors.black),
                      textAlign: TextAlign.start,
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: passwordController,
                      style: const TextStyle(fontSize: 16),
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: ElevatedButton(
                        onPressed: () {
                          // Call loginUser function to handle login
                          loginUser(context);
                        },
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.zero,
                          minimumSize: const Size(150, 36),
                          backgroundColor: const Color(0xFF004AAD),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Have Trouble signing in?'),
                        TextButton(
                          onPressed: () {
                            // Navigate to registration page
                          },
                          child: const Text(
                            'Contact Support',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Footer
          const Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              'Copyright 2024 St Pauls College Kalamassery',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}