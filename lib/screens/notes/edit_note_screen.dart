import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/notes_bloc.dart';
import 'package:todo_list/bloc/notes_events.dart';
import 'package:todo_list/bloc/notes_state.dart';
import 'package:todo_list/models/note_model.dart';
import 'package:todo_list/widgets/drawer.dart';

class EditNoteScreen extends StatefulWidget {
  final int index;

  EditNoteScreen({super.key,required this.index});

  @override
  _EditNoteScreenState createState() => _EditNoteScreenState(index: this.index);
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  final int index;

  _EditNoteScreenState({required this.index});

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
            title: Text('Редактировать заметку'),
            actions: [],
          ),
          body: Center(
            child: Column(
              children: [
                Text("Заголовок:"),
                TextFormField(
                  onChanged: (value) {
                    final event = ChangeTitleEvent(title: value);
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
                ElevatedButton(
                    onPressed: () {
                      if (state.title.length == 0) {
                        showError("Заполните название");
                        return;
                      }

                      if (state.content.length == 0) {
                        showError("Заполните содержание");
                        return;
                      }

                      var changedNote =
                          Note(title: state.title, content: state.content, id: state.id);
                      final event =
                          UpdateEvent(note: changedNote, index: this.index);
                      notesBloc.add(event);
                      Navigator.pop(context);
                    },
                    child: Text("Изменить")),
                OutlinedButton(
                    onPressed: () {
                      final NotesBloc notesBloc =
                          BlocProvider.of<NotesBloc>(context);
                      final event = DeleteEvent(index: this.index);
                      notesBloc.add(event);

                      Navigator.pop(context);
                    },
                    child: Text("Удалить"))
              ],
            ),
          ),
          drawer: MyDrawer(),
        );
      },
    );
  }
}
