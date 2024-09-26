import 'package:flutter/material.dart';
import 'package:todo_list/classes/geometry.dart';
import 'package:todo_list/widgets/drawer.dart';
import 'package:todo_list/widgets/shape_tile.dart';

class GeometryScreen extends StatefulWidget {
  @override
  _GeometryScreenState createState() => _GeometryScreenState();
}

class _GeometryScreenState extends State<GeometryScreen> {
  List<Shape> shapes = <Shape>[
      Square(width: 10),
      Rectangle(width: 10, height: 20),
      Circle(radius: 2),
      Square(width: 5),
      Rectangle(width: 1, height: 3),
      Circle(radius: 1),
    ];

  List<double> areas = [];

  /**
   * Демонстрация других методов Shape
   */
  void demonstrateOtherOptions() {
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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Количество уникальных'),
          content: Text(unique.length.toString()),
          actions: [],
        );
      },
    );
  
    // демонстрация обработки ошибок
    squaresMap['first']?.brokenMehod();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Геометрия'),
        actions: [
          IconButton(
              onPressed: () {
                demonstrateOtherOptions();
              },
              icon: Icon(Icons.accessible_sharp)),
        ],
      ),
      body: shapes.isEmpty
          ? Center(
              child: Text('Нет форм'),
            )
          : ListView.builder(
              itemCount: shapes.length,
              itemBuilder: (context, index) {
                return ShapeTile(shape: shapes[index]);
              },
            ),
      drawer: MyDrawer(),
    );
  }
}
