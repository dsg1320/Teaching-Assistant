// import 'package:flutter/material.dart';
// import 'package:teaching_assistant/components/colors.dart';
// import 'package:teaching_assistant/pages/note_list_page.dart';

// class NotePage extends StatefulWidget {
//   @override
//   _NotePageState createState() => _NotePageState();
// }

// class _NotePageState extends State<NotePage> {
//   final TextEditingController _noteController = TextEditingController();
//   List<String> notes = [];

//   void _saveNote() {
//     if (_noteController.text.isNotEmpty) {
//       setState(() {
//         notes.add(_noteController.text);
//         _noteController.clear();
//       });
//     }
//   }

//   void _viewAllNotes() {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => NotesListPage(notes: notes),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.primaryColor,
//       appBar: AppBar(
//         title: Text('Create Note'),
//         backgroundColor: AppColors.secondaryColor,
//         actions: [
//           TextButton(
//               onPressed: _saveNote,
//               child: Text(
//                 "save",
//                 style:
//                     TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
//               ))
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _noteController,
//               maxLines: 10,
//               decoration: InputDecoration(
//                 filled: true,
//                 fillColor: const Color.fromARGB(255, 251, 246, 230),
//                 border: OutlineInputBorder(),
//                 hintText: 'Write your note here...',
//               ),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _viewAllNotes,
//               child: Text('View All Notes'),
//               style: ElevatedButton.styleFrom(
//                 foregroundColor: const Color.fromARGB(255, 105, 93, 58),
//                 backgroundColor: AppColors.secondaryColor, // Text color
//                 padding: const EdgeInsets.symmetric(
//                     horizontal: 20, vertical: 12), // Add padding
//                 textStyle:
//                     const TextStyle(fontSize: 18), // Increase button text size
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
