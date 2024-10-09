import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:teaching_assistant/components/colors.dart';
import 'package:flutter_highlight/flutter_highlight.dart';
import 'package:flutter_highlight/themes/github.dart';

class ChatPage extends StatefulWidget {
  final String title;
  final String sessionId;
  final List<Map<String, String>> messages;
  final Function(List<Map<String, String>>) onUpdateMessages;

  ChatPage({
    required this.title,
    required this.sessionId,
    required this.messages,
    required this.onUpdateMessages,
  });

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isLoading = false;

  void _sendMessage() async {
    if (_controller.text.isEmpty) return;

    final userMessage = {'sender': 'user', 'text': _controller.text};

    // Update local messages with user's message
    setState(() {
      widget.messages.add(userMessage);
      _isLoading = true;
    });

    String apiUrl = "http://localhost:5000/api/v1/chats/chat";
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({
          'sessionId': widget.sessionId,
          'message': _controller.text,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseBody = json.decode(response.body);
        final modelResponse =
            responseBody['message'] ?? "Sorry, I didn't understand that.";


        setState(() {
          widget.messages.add({'sender': 'model', 'text': modelResponse});
          _isLoading = false;
        });
      } else {
        setState(() {
          widget.messages.add({
            'sender': 'model',
            'text': 'Failed to get a response from the assistant.',
          });
          _isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        widget.messages.add({
          'sender': 'model',
          'text': 'Error connecting to the assistant. Please try again.',
        });
        _isLoading = false;
      });
    }

    // Update messages in the parent widget
    widget.onUpdateMessages(widget.messages);

    // Clear the input field
    _controller.clear();

    // Scroll to the bottom after sending a message
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      }
    });
  }

  // Improved code block detection
  bool _isCodeSnippet(String message) {
    return message
        .contains(""); // Check if the message contains code delimiters
  }
  
   void _openQuickNotes() {
    showModalBottomSheet(
      context: context,
      builder: (context) => NotesListPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _isLoading
                  ? widget.messages.length + 1
                  : widget.messages.length,
              itemBuilder: (context, index) {
                if (_isLoading && index == widget.messages.length) {
                  return Shimmer.fromColors(
                    baseColor: AppColors.secondaryColor,
                    highlightColor: AppColors.primaryColor!,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  );
                }

                // Check if the message contains a code snippet
                if (widget.messages[index]['sender'] == 'model') {
                  if (_isCodeSnippet(widget.messages[index]['text']!)) {
                    final codeText = widget.messages[index]['text']!
                        .replaceAll("", ""); // Remove backticks

                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color.fromARGB(119, 0, 0, 0),
                            width: 0.5,
                          ),
                        ),
                        child: HighlightView(
                          codeText,
                          language:
                              'dart', // Define the language you want highlighted
                          theme: githubTheme, // Choose the theme
                          padding: const EdgeInsets.all(8),
                          textStyle: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(
                            color: const Color.fromARGB(119, 0, 0, 0),
                            width: 0.5,
                          ),
                        ),
                        child: Text(
                          widget.messages[index]['text']!,
                          style: const TextStyle(
                            fontFamily: 'Courier',
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }
                }

                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: FadeInAnimation(
                    child: Align(
                      alignment: widget.messages[index]['sender'] == 'user'
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: widget.messages[index]['sender'] == 'user'
                              ? const LinearGradient(
                                  colors: [
                                    AppColors.secondaryColor,
                                    Color.fromARGB(255, 211, 194, 138)
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                )
                              : const LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.transparent
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                          border: widget.messages[index]['sender'] != 'user'
                              ? Border.all(
                                  color: const Color.fromARGB(119, 0, 0, 0),
                                  width: 0.5,
                                )
                              : null,
                        ),
                        child: Text(
                          widget.messages[index]['text']!,
                          style: const TextStyle(
                              color: Color.fromARGB(255, 0, 0, 0)),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.02),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(
                          right: MediaQuery.of(context).size.width * 0.02),
                      child: TextField(
                        cursorColor: AppColors.accentColor,
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'Type a message...',
                          hintStyle: TextStyle(
                              color: const Color.fromARGB(104, 67, 67, 67)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.grey[400]!,
                              width: 1.0,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: AppColors.accentColor,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.grey[400]!,
                              width: 1.0,
                            ),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        style: TextStyle(
                            color: const Color.fromARGB(255, 22, 22, 22)),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.secondaryColor,
                      ),
                      child: Icon(
                        Icons.send,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}