import 'package:flutter/material.dart';
import 'package:teaching_assistant/components/colors.dart';

class Sidebar extends StatelessWidget {
  final List<String> chatTitles;
  final Function(String) onChatSelected;
  final Function(String) onNewChat;
  final Function(String) onDeleteChat;
  final Function(String) onEditChat;

  Sidebar({
    required this.chatTitles,
    required this.onChatSelected,
    required this.onNewChat,
    required this.onDeleteChat,
    required this.onEditChat,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text('Menu'),
            decoration: BoxDecoration(
              color: AppColors.accentColor,
            ),
          ),
          ...chatTitles.map((title) => ListTile(
                title: Text(title),
                onTap: () {
                  onChatSelected(title);
                },
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        onEditChat(title);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        onDeleteChat(title);
                      },
                    ),
                  ],
                ),
              )),
          ListTile(
            title: Text('New Chat'),
            onTap: () {
              onNewChat('');
            },
          ),
        ],
      ),
    );
  }
}
