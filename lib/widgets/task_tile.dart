import 'package:flutter/material.dart';
import 'package:todo_list/models/task_model.dart';

class TaskTile extends StatefulWidget {
  final Task task;
  TaskTile({required this.task});

  @override
  _TaskTileState createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title),
      trailing: Checkbox(
        value: widget.task.isCompleted,
        onChanged: (value) {
          setState(() {
    widget.task.isCompleted = value!;
  });

        },
      ),
    );
  }
}
