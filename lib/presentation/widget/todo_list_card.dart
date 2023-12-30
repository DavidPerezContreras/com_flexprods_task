import 'package:flutter/material.dart';
import 'package:nested_navigation/data/todo/remote/DTO/update_todo_request_dto.dart';
import 'package:nested_navigation/presentation/pages/save_todo/save_todo_page.dart';
import 'package:nested_navigation/provider/todo_provider.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../domain/model/todo.dart';

class TodoListCard extends StatefulWidget {
  const TodoListCard({
    required this.todo,
    required this.onIsCompleteChanged,
    super.key,
    required this.onUpdate,
  });

  final Todo todo;
  final Function(Todo, bool) onIsCompleteChanged;
  final Function(
    Todo todo, {
    required String title,
    required String description,
    DateTime? dueDate,
  })? onUpdate;

  @override
  State<TodoListCard> createState() => _TodoListCardState();
}

class _TodoListCardState extends State<TodoListCard> {
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  late final TodoProvider _todoProvider;
  @override
  void initState() {
    super.initState();
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(_topLevelNavigationProvider
                    .topLevelNavigation.currentState!.context)
                .push<UpdateTodoRequest>(
              MaterialPageRoute(
                builder: (context) => SaveTodoPage.update(
                  onUpdate: widget.onUpdate,
                  todo: widget.todo,
                ),
              ),
            )
                .then((updateTodoRequest) {
              if (updateTodoRequest != null) {
                _todoProvider.updateTodo(updateTodoRequest);
              }
            });
          },
          title: Text(widget.todo.title, overflow: TextOverflow.ellipsis),
          subtitle:
              Text(widget.todo.description, overflow: TextOverflow.ellipsis),
          trailing: Transform.scale(
            scale: 1.5, // Adjust the scale to make the checkbox larger
            child: Checkbox(
              value: widget.todo.isComplete,
              onChanged: (newValue) =>
                  widget.onIsCompleteChanged(widget.todo, newValue!),
            ),
          ),
        ),
      ),
    );
  }
}
