import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:teaching_assistant/components/colors.dart';
import 'package:teaching_assistant/components/sidebar.dart';
import 'package:teaching_assistant/pages/loginpage.dart';
import 'package:teaching_assistant/pages/loginpage.dart';
import 'dart:convert';
import 'chat_page.dart';
import 'loginpage.dart'; // Assuming you have a LoginPage

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<List<Map<String, String>>> allChats = [];
  List<String> chatTitles = [];
  //List<String> chatTitle = [];
  List<String> sessionIds = [];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  List<dynamic> sessions = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
    fetchSessions();
  }

  Future<void> fetchSessions() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('jwtToken');

      if (token != null) {
        final response = await http.get(
          Uri.parse(
              'https://teaching-assistant-production.up.railway.app/api/v1/sessions/get/${prefs.getString('userId')}'),
          headers: {
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode == 200) {
          setState(() {
            sessions = jsonDecode(response.body);
            print(sessions);
            chatTitles = sessions
                .map<String>((session) => session['sessionName'] as String)
                .toList();
            sessionIds = sessions
                .map<String>((session) => session['_id'] as String)
                .toList();
          });
        } else {
          print('Failed to load sessions');
        }
      } else {
        print('No token found');
      }
    } catch (e) {
      print('Error fetching sessions: $e');
    }
  }

  Future<void> startNewChat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId == null) {
      print('User ID not found');
      return;
    }
    String newTitle = 'Chat ${chatTitles.length + 1}';
    String apiUrl = "https://teaching-assistant-production.up.railway.app/api/v1/sessions/create-session";

    Map<String, String> requestBody = {
      'userId': userId,
      'sessionName': newTitle,
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        if (responseBody.containsKey('session')) {
          String sessionId = responseBody['session']['_id'];

          setState(() {
            allChats.add([
              {'sender': 'model', 'text': 'Hello, how can I assist you today?'}
            ]);
            chatTitles.add(newTitle);
            sessionIds.add(sessionId);
          });

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                title: newTitle,
                sessionId: sessionId,
                messages: allChats.last,
                onUpdateMessages: (newMessages) {
                  setState(() {
                    allChats[allChats.length - 1] = newMessages;
                  });
                },
              ),
            ),
          );
        } else {
          print('Session ID not found in the response: ${response.body}');
        }
      } else {
        print(
            'Failed to create session: ${response.statusCode} - ${response.body}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void openChat(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('jwtToken');

    if (token == null) {
      print('No token found');
      return;
    }

    final response = await http.get(
      Uri.parse(
          'http://10.0.2.2:5001/api/v1/sessions/chat/${sessionIds[index]}'),
      headers: {
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> decodedResponse = jsonDecode(response.body);
      List<Map<String, String>> chatHistory = decodedResponse.map((item) {
        return {
          'sender': item['role'].toString(),
          'text': item['content'].toString(),
        };
      }).toList();

      //print(chatHistory);

      if (chatHistory == null) {
        chatHistory = [];
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChatPage(
            title: chatTitles[index],
            sessionId: sessionIds[index],
            messages: chatHistory,
            onUpdateMessages: (newMessages) {
              setState(() {
                allChats[index] = newMessages;
              });
            },
          ),
        ),
      );
    } else {
      print('Failed to load chat history');
    }
  }

  // Function to display Logout confirmation dialog
  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage()), // Navigate to login page
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryColor),
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          'A.T.L.A.S',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 28, // Increased font size for better visibility
            foreground: Paint()
              ..shader = const LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.primaryColor,
                  AppColors.accentColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Logout icon
            onPressed: _showLogoutDialog, // Show logout confirmation dialog
          ),
        ],
      ),
      drawer: Sidebar(
        chatTitles: chatTitles,
        onChatSelected: (title) {
          //print('Selected Chat Title: $title');
          //print(chatTitles);
          int index = chatTitles.indexOf(title);
          if (index != -1) {
            openChat(index);
          } else {
            print('Error: Chat title not found');
          }
        },
        onNewChat: (newTitle) {
          startNewChat();
        },
        onDeleteChat: (title) {
          int index = chatTitles.indexOf(title);
          if (index != -1) {
            setState(() {
              allChats.removeAt(index);
              chatTitles.removeAt(index);
              sessionIds.removeAt(index);
            });
          }
        },
        onEditChat: (title) {
          int index = chatTitles.indexOf(title);
          if (index != -1) {
            showDialog(
              context: context,
              builder: (context) {
                final TextEditingController titleController =
                    TextEditingController(text: title);
                return AlertDialog(
                  title: const Text('Edit Chat Title'),
                  content: TextField(
                    controller: titleController,
                    decoration:
                        const InputDecoration(hintText: 'Enter new title'),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          chatTitles[index] = titleController.text;
                        });
                        Navigator.of(context).pop();
                      },
                      child: const Text('Save'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Hi, I'm ATLAS \n Let's Learn!",
                style: TextStyle(
                  fontSize: 24, // Adjusted font size for the greeting
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(
                      255, 29, 29, 29), // Make sure the text stands out
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: startNewChat,
                style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 105, 93, 58),
                  backgroundColor: AppColors.secondaryColor, // Text color
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 12), // Add padding
                  textStyle: const TextStyle(
                      fontSize: 18), // Increase button text size
                ),
                child: const Text('Start New Chat'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
