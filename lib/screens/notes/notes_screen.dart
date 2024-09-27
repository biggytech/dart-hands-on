import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/notes_bloc.dart';
import 'package:todo_list/bloc/notes_events.dart';
import 'package:todo_list/bloc/notes_state.dart';
import 'package:todo_list/screens/notes/add_note_screen.dart';
import 'package:todo_list/widgets/drawer.dart';
import 'package:todo_list/widgets/note_tile.dart';

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  void navigateToAddNoteScreen(BuildContext context) {
    final NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);

    final event1 = ChangeTitleEvent(title: "");
    notesBloc.add(event1);
    final event2 = ChangeContentEvent(content: "");
    notesBloc.add(event2);

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => new AddNoteScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);

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
      body: BlocBuilder<NotesBloc, NoteState>(
        builder: (context, state) {
          return state.notes.isEmpty
              ? Center(
                  child: Text('Нет заметок'),
                )
              : GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 8 / 9,
                  children: List.generate(state.notes.length, (index) {
                    return NoteTile(
                      note: state.notes[index],
                      index: index,
                    );
                  }),
                );
        },
      ),
      drawer: MyDrawer(),
    );
  }
}
