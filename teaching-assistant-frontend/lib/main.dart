import 'package:flutter/material.dart';
import 'package:teaching_assistant/pages/loginpage.dart';
import 'package:teaching_assistant/pages/splashscreen.dart';
//

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashScreen(),
    );
  }
}
