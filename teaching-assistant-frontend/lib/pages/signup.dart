import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:teaching_assistant/pages/homepage.dart';
import 'package:teaching_assistant/pages/loginpage.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _name = '';

  Future<void> _signup() async {
    final response = await http.post(
      Uri.parse(
          'https://teaching-assistant-production.up.railway.app/api/v1/user/signup'), // Your signup endpoint
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'username': _name,
        'email': _email,
        'password': _password,
      }),
    );

    if (response.statusCode == 200) {
      // Successfully signed up
      final jsonResponse = jsonDecode(response.body);
      print('Signup successful: ${jsonResponse}');

      // Store the signup status in shared preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_signed_up', true);

      // Navigate to the HomePage after successful signup
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => HomePage()), // Change to your HomePage widget
      );
    } else {
      // Handle error response
      final errorResponse = response.body;
      print('Error: $errorResponse');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: $errorResponse')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Signup')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Name'),
                onChanged: (value) {
                  setState(() {
                    _name = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Email'),
                onChanged: (value) {
                  setState(() {
                    _email = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                onChanged: (value) {
                  setState(() {
                    _password = value;
                  });
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _signup(); // Call the signup function
                  }
                },
                child: Text('Signup'),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  // Navigate to the login page
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            LoginPage()), // Change to your LoginPage widget
                  );
                },
                child: Text('Already have an account? Login here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
