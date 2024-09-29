import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teaching_assistant/pages/homepage.dart';
import 'package:teaching_assistant/pages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teaching Assistant',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false, // Remove the debug banner
      home: FutureBuilder<bool>(
        future: _checkIfSignedUp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data!) {
            return HomePage(); // Navigate to HomePage if signed up
          } else {
            return SignupPage(); // Show SignupPage if not signed up
          }
        },
      ),
    );
  }

  Future<bool> _checkIfSignedUp() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_signed_up') ?? false; // Check if user is signed up
  }
}
