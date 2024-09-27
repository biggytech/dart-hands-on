import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/notes_bloc.dart';
import 'package:todo_list/bloc/notes_events.dart';
import 'package:todo_list/bloc/notes_state.dart';
import 'package:todo_list/models/note_model.dart';
import 'package:todo_list/widgets/drawer.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  void showError(String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(msg),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);

    return BlocBuilder<NotesBloc, NoteState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Добавить новую заметку'),
            actions: [],
          ),
          body: Center(
            child: Column(
              children: [
                Text("Заголовок:"),
                TextFormField(
                  onChanged: (value) {
                    final event = ChangeTitleEvent(title: value);
                    // Вызовите метод добавления события в BLoC
                    notesBloc.add(event);
                  },
                  decoration: InputDecoration(
                      hintText: "Заголовок",
                      contentPadding: EdgeInsets.all(20)),
                  initialValue: state.title,
                ),
                SizedBox(height: 20),
                Text("Содержание:"),
                TextFormField(
                  maxLines: 10,
                  onChanged: (value) {
                    final event = ChangeContentEvent(content: value);
                    notesBloc.add(event);
                  },
                  decoration: InputDecoration(
                      hintText: "Содержание",
                      contentPadding: EdgeInsets.all(20)),
                  initialValue: state.content,
                ),
                SizedBox(height: 20),
                OutlinedButton(
                    onPressed: () {
                      if (state.title.length == 0) {
                        showError("Заполните название");
                        return;
                      }

                      if (state.content.length == 0) {
                        showError("Заполните содержание");
                        return;
                      }

                      var newNote =
                          Note(title: state.title, content: state.content);
                      final event = AddEvent(note: newNote);
                      notesBloc.add(event);

                      Navigator.pop(context);
                    },
                    child: Text("Добавить"))
              ],
            ),
          ),
          drawer: MyDrawer(),
        );
      },
    );
  }
}
