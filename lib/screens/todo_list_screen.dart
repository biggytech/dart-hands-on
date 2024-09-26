import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';
import 'package:todo_list/widgets/drawer.dart';
import 'package:todo_list/widgets/task_tile.dart';

class TodoListScreen extends StatefulWidget {
  @override
  _TodoListScreenState createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  List<Task> tasks = [];

  void addNewTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTaskTitle = '';

        return AlertDialog(
          title: Text('Add Task'),
          content: TextField(
            onChanged: (value) {
              newTaskTitle = value;
            },
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  tasks.add(Task(title: newTaskTitle));
                });
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          // кнопка добавления
          IconButton(
              onPressed: () {
                addNewTask();
              },
              icon: Icon(Icons.add)),
        ],
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text('List is empty'),
            )
          : ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskTile(task: tasks[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addNewTask();
        },
        child: Icon(Icons.add),
      ),
      drawer: MyDrawer(),
    );
  }
}
