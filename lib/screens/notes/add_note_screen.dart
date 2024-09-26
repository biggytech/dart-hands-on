import 'package:flutter/material.dart';
import 'package:todo_list/models/note_model.dart';
import 'package:todo_list/widgets/drawer.dart';

class AddNoteScreen extends StatefulWidget {
  @override
  _AddNoteScreenState createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  String title = "";
  String content = "";

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
        title: Text('Добавить новую заметку'),
        actions: [],
      ),
      body: Center(
        child: Column(
          children: [
            Text("Заголовок:"),
            TextField(onChanged: (value) {
              title = value;
            }, decoration: InputDecoration(
              hintText: "Заголовок",
              contentPadding: EdgeInsets.all(20)
            ),),
            SizedBox(height: 20),
            Text("Содержание:"),
            TextField(maxLines: 10, onChanged: (value) {
              content = value;
            }, decoration: InputDecoration(
              hintText: "Содержание",
              contentPadding: EdgeInsets.all(20)
            )),
            SizedBox(height: 20),
            OutlinedButton(onPressed: () {
              if (title.length == 0) {
                showError("Заполните название");
                return;
              }

              if (content.length == 0) {
                showError("Заполните содержание");
                return;
              }

              var newNote = Note(title: title, content: content);
              Navigator.pop(context, newNote);
            }, child: Text("Добавить"))
          ],
        ),
      ),drawer: MyDrawer(),
    );
  }
}
