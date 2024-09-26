import 'package:flutter/material.dart';
import 'package:todo_list/classes/geometry.dart';

class ShapeTile extends StatefulWidget {
  final Shape shape;
  ShapeTile({required this.shape});

  @override
  _ShapeTileState createState() => _ShapeTileState();
}

class _ShapeTileState extends State<ShapeTile> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.shape.getTitle()),
      subtitle: Text(widget.shape.getDetails()),
    );
  }
}
