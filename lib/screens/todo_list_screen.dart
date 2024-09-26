import 'package:flutter/material.dart';
import 'package:todo_list/classes/geometry.dart';
import 'package:todo_list/models/task_model.dart';
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

  // для лабы 2
  void showListAreas() {
    // Создать массив объектов 'Shape' и вывести их площади
    String areasMsg = '';

    var list = <Shape>[
      Square(width: 10),
      Rectangle(width: 10, height: 20),
      Circle(radius: 2),
      Square(width: 5),
      Rectangle(width: 1, height: 3),
      Circle(radius: 1),
    ];

    int length = list.length;

    for (int i = 0; i < length; i++) {
      // демонстрация использование continue
      if (i == 0) {
        // пропустить первый
        continue;
      }

      // демонстрация использования break
      if (i == length-1) {
        // прерваться на последнем
        break;
      }

      double area = list[i].calculateArea();
      areasMsg = areasMsg + area.toString()
        + (i != length-1 ? ', ' : '');
    }

    // ввывести окно с площадями
    // по итогу должно быть:
    // 200, 12.56, 25, 3 (пропущены первый и посл.)
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Shape Areas'),
          content: Text(areasMsg),
          actions: [],
        );
      },
    );

    // Использовать коллекцию для хранения объектов класса 'Square'.
    var squaresMap = Map<String, Square>();
    squaresMap['first'] = Square.fromWidth(4.0);
    squaresMap['second'] = Square.fromWidth(3.0);

    // Демонстрация использования множества для хранения уникальных значений.
    var unique = Set<String>();
    unique.add('a');
    unique.add('b');
    unique.add('a');

    // длина должна быть 2 т.к. удалили неуникальные
    // showDialog(
    //   context: context,
    //   builder: (BuildContext context) {
    //     return AlertDialog(
    //       title: Text('Unique Count'),
    //       content: Text(unique.length.toString()),
    //       actions: [],
    //     );
    //   },
    // );
  
    // демонстрация обработки ошибок
    list[0].brokenMehod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          // кнопка добавления
          IconButton(onPressed: () {
            addNewTask();
          }, icon: Icon(Icons.add)),
          // кнопка вывести лист
          IconButton(onPressed: () {
            showListAreas();
          }, icon: Icon(Icons.accessible_sharp))
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
    );
  }
}
