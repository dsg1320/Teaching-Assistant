import 'package:flutter/material.dart';
import 'package:teaching_assistant/components/colors.dart';

class BottomInput extends StatefulWidget {
  @override
  _BottomInputState createState() => _BottomInputState();
}

class _BottomInputState extends State<BottomInput> {
  final TextEditingController controller = TextEditingController();
  List<Map<String, String>> messages = []; // List to hold messages

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              bool isUserMessage = messages[index]['sender'] == 'user';

              return Align(
                alignment: isUserMessage
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  decoration: BoxDecoration(
                    color: isUserMessage
                        ? AppColors.secondaryColor
                        : AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (!isUserMessage) ...[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.asset(
                            'images/ai_logo.png',
                            width: 30,
                            height: 30,
                          ),
                        ),
                      ],
                      Flexible(
                        child: Text(
                          messages[index]['text']!,
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),

        // Bottom input section
        Container(
          padding: EdgeInsets.only(
            bottom: screenHeight * 0.05,
            top: screenHeight * 0.01,
            left: screenWidth * 0.05,
            right: screenWidth * 0.05,
          ),
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: screenHeight * 0.06,
                  height: screenHeight * 0.05,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.secondaryColor,
                    border: Border.all(
                      color: AppColors.accentColor,
                      width: 1.0,
                    ),
                  ),
                  child: IconButton(
                    iconSize: screenHeight * 0.025,
                    icon: const Icon(
                      Icons.file_copy_outlined,
                      color: AppColors.accentColor,
                    ),
                    onPressed: () {
                      print('Additional button pressed');
                    },
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                flex: 6,
                child: Container(
                  height: screenHeight * 0.05,
                  child: Center(
                    child: TextField(
                      controller: controller,
                      textAlignVertical: TextAlignVertical.center,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                        hintText: 'Enter your text',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: MediaQuery.of(context).size.width * 0.035,
                        ),
                        filled: true,
                        fillColor: AppColors.secondaryColor,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          borderSide: const BorderSide(
                            color: AppColors.accentColor,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(100.0),
                          borderSide: const BorderSide(
                            color: AppColors.accentColor,
                            width: 1.0,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: IconButton(
                            iconSize: screenHeight * 0.025,
                            icon: const Icon(Icons.send),
                            onPressed: () {
                              String text = controller.text.trim();
                              if (text.isNotEmpty) {
                                // Add user message
                                setState(() {
                                  messages.insert(
                                      0, {'sender': 'user', 'text': text});
                                  controller.clear();

                                  // Simulate model response after user sends a message
                                  Future.delayed(Duration(milliseconds: 0), () {
                                    setState(() {
                                      // Add model response
                                      messages.insert(0, {
                                        'sender': 'model',
                                        'text':
                                            'This is a simulated response to: "$text"'
                                      });
                                    });
                                  });
                                });
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
