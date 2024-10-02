import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teaching_assistant/components/colors.dart';
import 'dart:convert';

import 'package:teaching_assistant/pages/chat_page.dart';
import 'package:teaching_assistant/pages/homepage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String message = '';

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isNotEmpty && password.isNotEmpty) {
      String apiUrl =
          "http://localhost:5001/api/v1/user/login"; // Your API URL for login

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {"Content-Type": "application/json"},
          body: json.encode({
            'email': email,
            'password': password,
          }),
        );

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);

          // Set the success message
          setState(() {
            message = responseBody['message'] ?? 'Login successful!';
          });

          // Navigate to the HomePage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          setState(() {
            message = 'Login failed: ${response.body}';
          });
        }
      } catch (error) {
        setState(() {
          message = 'Error connecting to the server. Please try again.';
        });
        print('Network error: $error');
      }
    } else {
      setState(() {
        message = 'Please fill in both fields.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Add the image at the top
            Image.asset(
              'images/ai_logo.png', // Replace with your image path
              height: 65,
              width: 65,
            ),
            SizedBox(height: 16.0),

            // Add "Login" text heading
            Text(
              'Welcome back!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24.0),

            // Email input field
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16.0),

            // Password input field
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            SizedBox(height: 16.0),

            // Gradient login button
            Container(
              width: double.infinity, // Match width of text fields
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accentColor,
                    AppColors.secondaryColor,
                    AppColors.accentColor
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ElevatedButton(
                onPressed: login,
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.transparent, // Set background to transparent
                  shadowColor: Colors.transparent, // Remove shadow
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),

            // Error message display
            Text(
              message,
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
