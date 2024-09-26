import 'package:flutter/material.dart';
import 'package:todo_list/models/note_model.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:todo_list/screens/notes/edit_note_screen.dart';

class NoteTile extends StatefulWidget {
  final Note note;
  final ValueSetter<Note> onUpdateCallback;

  NoteTile({required this.note, required this.onUpdateCallback});

  @override
  _NoteTileState createState() =>
      _NoteTileState(note: this.note, onUpdateCallback: this.onUpdateCallback);
}

class _NoteTileState extends State<NoteTile> {
  final Note note;
  final ValueSetter<Note> onUpdateCallback;

  _NoteTileState({required this.note, required this.onUpdateCallback});

  Future<void> navigateToEditNoteScreen(BuildContext context) async {
    final updatedNote = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(note: note),
      ),
    );

    setState(() {
      onUpdateCallback(updatedNote);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.note.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Text(
              widget.note.content,
            overflow: TextOverflow.ellipsis,
              maxLines: 9),
            Spacer(),
            Text(DateFormat('yyyy-MM-dd – kk:mm').format(widget.note.updatedAt))
          ],
        ),
        shape: RoundedRectangleBorder(side: BorderSide(color: Colors.black)),
        contentPadding: EdgeInsets.all(20),
        // случайный цвет
        tileColor: Color((math.Random().nextDouble() * 0xFFFFFF).toInt())
            .withOpacity(0.25),
        onTap: () {
          navigateToEditNoteScreen(context);
        },
      ),
    );
  }
}
