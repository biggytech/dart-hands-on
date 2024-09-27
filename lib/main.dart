import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/bloc/notes_bloc.dart';
import 'package:todo_list/screens/todo_list_screen.dart';

void main() {
  // https://stackoverflow.com/questions/50687801/flutter-unhandled-exception-missingpluginexceptionno-implementation-found-for
  SharedPreferences.setMockInitialValues({});

  runApp(MultiBlocProvider(providers: [
    BlocProvider<NotesBloc>(
      create: (context) => NotesBloc(),
    ),
  ], child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TodoListScreen(),
    );
  }
}
