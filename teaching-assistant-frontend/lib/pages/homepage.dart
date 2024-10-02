import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teaching_assistant/components/colors.dart';
import 'package:teaching_assistant/components/sidebar.dart';
import 'dart:convert';
import 'chat_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  final List<List<Map<String, String>>> allChats = [];
  final List<String> chatTitles = [];
  final List<String> sessionIds = [];
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  Future<void> startNewChat() async {
    String newTitle = 'Chat ${chatTitles.length + 1}';
    String apiUrl = "http://localhost:5001/api/v1/sessions/create-session";

    Map<String, String> requestBody = {
      'userId': '66f822c382f1a2aa111beaec',
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

  void openChat(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatPage(
          title: chatTitles[index],
          sessionId: sessionIds[index],
          messages: allChats[index],
          onUpdateMessages: (newMessages) {
            setState(() {
              allChats[index] = newMessages;
            });
          },
        ),
      ),
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
      ),
      drawer: Sidebar(
        chatTitles: chatTitles,
        onChatSelected: (title) {
          int index = chatTitles.indexOf(title);
          openChat(index);
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
