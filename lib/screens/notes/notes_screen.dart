import 'package:flutter/material.dart';
import 'package:todo_list/models/note_model.dart';
import 'package:todo_list/screens/notes/add_note_screen.dart';
import 'package:todo_list/widgets/drawer.dart';
import 'package:todo_list/widgets/note_tile.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> notes = <Note>[];

  Future<void> navigateToAddNoteScreen(BuildContext context) async {
    final createdNote = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => new AddNoteScreen()));

    setState(() {
      notes.add(createdNote);
    });
  }

  void updateNote(int index, Note note) {
    setState(() {
      notes[index] = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Заметки'),
        actions: [
          // кнопка добавления
          IconButton(
              onPressed: () {
                navigateToAddNoteScreen(context);
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: notes.isEmpty
          ? Center(
              child: Text('Нет заметок'),
            )
          : GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 8/9,
              children: List.generate(notes.length, (index) {
                return NoteTile(note: notes[index], onUpdateCallback: (Note note) {
                  updateNote(index, note);
                },);
              }),
            ),
      drawer: MyDrawer(),
    );
  }
}
