import 'package:flutter/material.dart';
import 'package:teaching_assistant/components/colors.dart';

class NoteDetailPage extends StatefulWidget {
  final String initialNote;

  NoteDetailPage({required this.initialNote});

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<NoteDetailPage> {
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _noteController = TextEditingController(text: widget.initialNote);
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  void _saveNote() {
    Navigator.pop(context, _noteController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Details'),
        backgroundColor: AppColors.secondaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveNote,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: TextField(
            controller: _noteController,
            maxLines: null,
            decoration: InputDecoration(
              hintText: 'Edit your note...',
            ),
          ),
        ),
      ),
    );
  }
}
