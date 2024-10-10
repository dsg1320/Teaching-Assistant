import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  double averageScore = 0.0;

  @override
  void initState() {
    super.initState();
    fetchAverageScore();
  }

   Future<void> fetchAverageScore() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');
      String? token = prefs.getString('jwtToken');

      if (userId != null && token != null) {
        final response = await http.get(
          Uri.parse('http://10.0.2.2:5001/api/v1/sessions/average-performance/$userId'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          final responseBody = json.decode(response.body);
          setState(() {
            averageScore = responseBody['averagePerformanceScore'];
          });
        } else {
          print('Failed to load average score');
        }
      } else {
        print('User ID or token not found');
      }
    } catch (e) {
      print('Error fetching average score: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Text(
          'Average Performance Score: $averageScore',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
