import 'package:flutter/material.dart';
import 'package:todo_list/screens/geometry_screen.dart';
import 'package:todo_list/screens/notes/notes_screen.dart';
import 'package:todo_list/screens/quotes_screen.dart';
import 'package:todo_list/screens/todo_list_screen.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              title: const Text("Лаба 4-5, 7"),
              onTap: () {
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
