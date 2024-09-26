import 'package:flutter/material.dart';
import 'package:teaching_assistant/pages/homepage.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the screen width for responsiveness
    final double screenWidth = MediaQuery.of(context).size.width;

    // Define the border radius to be consistent for input fields and the button
    const double borderRadius = 10.0;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Center the column content
          crossAxisAlignment:
              CrossAxisAlignment.center, // Align children to center
          children: [
            // Image at the top
            Image.asset(
              'images/ai_logo.png', // Replace with your image asset
              height: 70, // Adjust height as needed
            ),

            const SizedBox(height: 20), // Spacing between elements

            // "Create an account" text
            const Text(
              'Create an account',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20), // Spacing between elements

            // Username input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Spacing between elements

            // Password input field
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
                obscureText: true, // To hide the password input
              ),
            ),

            const SizedBox(height: 20), // Spacing between elements

            // Login Button with gradient background
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: screenWidth *
                    0.85, // Responsive width (85% of screen width)
                height: 50, // Fixed height for button
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                  gradient: const LinearGradient(
                    colors: [
                      Color.fromRGBO(212, 182, 85, 1),
                      Color.fromRGBO(255, 243, 205, 1),
                      Color.fromRGBO(212, 182, 85, 1)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    stops: [0.0, 0.51, 0.84],
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              HomePage()), // Navigate to HomePage
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor:
                        Colors.transparent, // To keep the gradient visible
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20), // Spacing between elements

            // "Want to create an account?" text
            const Text('Want to create an account?'),

            // Yellow "Login" text
            GestureDetector(
              onTap: () {
                // Define what happens on tapping this text
                print('Login tapped');
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Color.fromRGBO(212, 182, 85, 1),
                  fontSize: 22, // Slightly bigger text
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
