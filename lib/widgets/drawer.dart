import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list/bloc/notes_bloc.dart';
import 'package:todo_list/bloc/notes_events.dart';
import 'package:todo_list/managers/FirebaseManager.dart';
import 'package:todo_list/screens/geometry_screen.dart';
import 'package:todo_list/screens/notes/notes_screen.dart';
import 'package:todo_list/screens/quotes_screen.dart';
import 'package:todo_list/screens/todo_list_screen.dart';

class MyDrawer extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final NotesBloc notesBloc = BlocProvider.of<NotesBloc>(context);

    return Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(child: Text('Лабы')),
            ListTile(
              title: const Text("Лаба 1"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new TodoListScreen()));
              },
            ),
            ListTile(
              title: const Text("Лаба 2"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new GeometryScreen()));
              },
            ),
            ListTile(
              title: const Text("Лаба 3, 6"),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new QuotesScreen()));
              },
            ),
            ListTile(
              title: const Text("Лаба 4-5, 7-8"),
              onTap: () async {
                var manager = FirebaseManager();
                var notes = await manager.getNotes();

                final event1 = InitializeEvent(notes: notes);
                notesBloc.add(event1);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => new NotesScreen ()));
              },
            ),
          ],
        ),
      );
  }
}
