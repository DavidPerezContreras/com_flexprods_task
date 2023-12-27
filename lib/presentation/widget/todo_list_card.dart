import 'package:flutter/material.dart';

import '../../domain/model/todo.dart';

class TodoListCard extends StatefulWidget {
  const TodoListCard({
    required this.todo,
    required this.onIsCompleteChanged,
    super.key,
  });

  final Todo todo;
  final Function(Todo,bool) onIsCompleteChanged;

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
          onTap:(){},
          title: Text(widget.todo.title, overflow: TextOverflow.ellipsis),
          subtitle: Text(widget.todo.description, overflow: TextOverflow.ellipsis),
          trailing: Transform.scale(
            scale: 1.5, // Adjust the scale to make the checkbox larger
            child: Checkbox(
              value: widget.todo.isComplete,
              onChanged: (newValue) => widget.onIsCompleteChanged(widget.todo, newValue!),
            ),
          ),
        ),
      ),
    );
  }
}
