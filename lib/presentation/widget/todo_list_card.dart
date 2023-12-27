import 'package:flutter/material.dart';

import '../../domain/model/todo.dart';

class TodoListCard extends StatefulWidget {
  const TodoListCard({
    required this.todo,
    super.key,
  });

  final Todo todo;

  @override
  State<TodoListCard> createState() => _TodoListCardState();
}

class _TodoListCardState extends State<TodoListCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Card(
        child: ListTile(
          title: Text(widget.todo.title),
          subtitle: Text(widget.todo.description),
        ),
      ),
    );
  }
}
