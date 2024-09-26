import 'package:flutter/material.dart';
import 'package:teaching_assistant/components/colors.dart';

class BottomInput extends StatefulWidget {
  @override
  _BottomInputState createState() => _BottomInputState();
}

class _BottomInputState extends State<BottomInput> {
  final TextEditingController controller = TextEditingController();
  List<String> messages = [];
  int? editingIndex;
  int? expandedIndex;

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
              bool isModelMessage = index == 0;

              return GestureDetector(
                onLongPress: () {
                  if (!isModelMessage) {
                    setState(() {
                      controller.text = messages[index];
                      editingIndex = index;
                      expandedIndex = index;
                    });
                  }
                },
                child: Align(
                  alignment: isModelMessage
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                    decoration: BoxDecoration(
                      color: isModelMessage
                          ? AppColors.primaryColor
                          : AppColors.secondaryColor,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment
                          .center, // Aligns the image and text vertically in the center
                      children: [
                        if (isModelMessage) ...[
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
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: isModelMessage
                                ? CrossAxisAlignment.start
                                : CrossAxisAlignment.end,
                            children: [
                              if (expandedIndex != index) ...[
                                Text(
                                  messages[index],
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: isModelMessage
                                        ? Colors.black
                                        : Colors.black,
                                  ),
                                ),
                              ],
                              if (expandedIndex == index) ...[
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxHeight: 150.0),
                                  child: SingleChildScrollView(
                                    child: TextField(
                                      controller: controller,
                                      maxLines: null,
                                      onSubmitted: (text) {
                                        setState(() {
                                          messages[index] = text;
                                          controller.clear();
                                          expandedIndex =
                                              null; // Collapse the bubble
                                        });
                                      },
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'Edit message...',
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    ),
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
                              setState(() {
                                String text = controller.text.trim();
                                if (text.isNotEmpty) {
                                  messages.insert(0, text);
                                  controller.clear();
                                }
                              });
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
