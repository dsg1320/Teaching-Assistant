import 'package:flutter/material.dart';
import 'package:teaching_assistant/components/colors.dart';
import 'package:teaching_assistant/components/sidebar.dart';
import 'package:teaching_assistant/components/bottom_input.dart'; // Import the new bottom input file

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: Row(
          children: [
            // Flexible space to push the title to the center
            const Spacer(),
            Hero(
              tag: 'logo', // Same tag as SplashScreen
              child: Image.asset(
                'images/ai_logo.png', // Your logo image
                width: 40, // Smaller logo size in AppBar
                height: 40,
              ),
            ),
            // const SizedBox(width: 10), // Space between logo and title
            // const Text('Homepage'),
            // Flexible space to push the title to the center
            const Spacer(),
          ],
        ),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications), // Use a different icon if desired
            onPressed: () {
              // Add functionality for the notifications button here
              print('Notifications tapped'); // Example action
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(4.0),
          child: Container(
            height: 1.0,
          ),
        ),
      ),
      drawer: Sidebar(),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 100,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              'Line number ${index + 1}',
              style: TextStyle(color: Colors.black),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomInput(),
    );
  }
}
