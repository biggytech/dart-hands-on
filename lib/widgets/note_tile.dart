import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/notes_bloc.dart';
import 'package:todo_list/bloc/notes_events.dart';
import 'package:todo_list/models/note_model.dart';
import 'dart:math' as math;
import 'package:intl/intl.dart';
import 'package:todo_list/screens/notes/edit_note_screen.dart';

class NoteTile extends StatefulWidget {
  final Note note;
  final int index;

  NoteTile({required this.note, required this.index});

  @override
  _NoteTileState createState() =>
      _NoteTileState(note: this.note, index: this.index);
}

class _NoteTileState extends State<NoteTile> {
  final Note note;
  final int index;

  _NoteTileState({required this.note, required this.index});

  void navigateToEditNoteScreen(BuildContext context) {
    final NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);

    final event = LoadEvent(index: this.index);
    notesBloc.add(event);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EditNoteScreen(index: index),
      ),
    );
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
