import 'package:flutter/material.dart';
import 'package:teaching_assistant/components/colors.dart';
import 'note_detail_page.dart';

class NotesListPage extends StatefulWidget {
  @override
  _NotesListPageState createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  List<String> notes = [];

  void _addNewNote() async {
    final newNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteDetailPage(initialNote: ''),
      ),
    );

    if (newNote != null) {
      setState(() {
        notes.add(newNote);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      appBar: AppBar(
        title: Text('All Notes'),
        backgroundColor: AppColors.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: notes.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () async {
                final editedNote = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        NoteDetailPage(initialNote: notes[index]),
                  ),
                );

                if (editedNote != null) {
                  setState(() {
                    notes[index] = editedNote;
                  });
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(18),
                  color: Color.fromARGB(255, 251, 246, 230),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Note ${index + 1}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 5),
                    Text(
                      notes[index],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewNote,
        child: Icon(Icons.add),
        backgroundColor: AppColors.secondaryColor,
      ),
    );
  }
}
