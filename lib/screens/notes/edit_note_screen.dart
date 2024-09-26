import 'package:flutter/material.dart';
import 'package:todo_list/models/note_model.dart';
import 'package:todo_list/widgets/drawer.dart';

class EditNoteScreen extends StatefulWidget {
  final Note note;

  EditNoteScreen({super.key, required this.note});

  @override
  _EditNoteScreenState createState() =>
      _EditNoteScreenState(title: note.title, content: note.content);
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  String title = "";
  String content = "";

  _EditNoteScreenState({required this.title, required this.content});

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
                title = value;
              },
              decoration: InputDecoration(
                  hintText: "Заголовок", contentPadding: EdgeInsets.all(20)),
              initialValue: this.title,
            ),
            SizedBox(height: 20),
            Text("Содержание:"),
            TextFormField(
              maxLines: 10,
              onChanged: (value) {
                content = value;
              },
              decoration: InputDecoration(
                  hintText: "Содержание", contentPadding: EdgeInsets.all(20)),
              initialValue: this.content,
            ),
            SizedBox(height: 20),
            OutlinedButton(
                onPressed: () {
                  if (title.length == 0) {
                    showError("Заполните название");
                    return;
                  }

                  if (content.length == 0) {
                    showError("Заполните содержание");
                    return;
                  }

                  var changedNote = Note(title: title, content: content);
                  Navigator.pop(context, changedNote);
                },
                child: Text("Изменить"))
          ],
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}
