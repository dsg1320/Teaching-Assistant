// lib/code_display.dart
import 'package:flutter/material.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/dracula.dart'; // Import dark theme

class CodeDisplay extends StatelessWidget {
  final String codeText;

  CodeDisplay({required this.codeText}); // Pass the code text to be displayed

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Code Example'),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: HighlightView(
          codeText, // The code to display
          language: 'dart', // Specify the language for highlighting
          theme: draculaTheme, // Use dark theme
          padding: const EdgeInsets.all(12),
          textStyle: TextStyle(
            fontFamily: 'Courier New',
            fontSize: 14,
            color: Colors.white, // Customize text color
          ),
        ),
      ),
      backgroundColor: Colors.black, // Dark background
    );
  }
}
