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
    DateTime? dueDate = widget.todo.dueDate;
    final String? dueDateText = dueDate != null
        ? " ${dueDate.day} / ${dueDate.month} / ${dueDate.year}"
        : null;
    return Dismissible(
      key: Key(widget.todo.id.toString()),
      onDismissed: (direction) {
        _todoProvider.deleteTodo(widget.todo);
      },
      // Show a red background as the item is swiped away.
      background: Container(color: Colors.red),

      child: Card(
        child: ListTile(
          onTap: () async {
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
            setState(() {});
          },
          title: Text(
            widget.todo.title,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              // change this to suit your needs
              fontWeight: FontWeight.bold, // makes the text bold
              // change this to suit your needs
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.todo.description,
                overflow: TextOverflow.ellipsis,
                maxLines: 8,
              ),
              dueDate != null
                  ? Row(
                      children: [
                        Icon(Icons.calendar_month),
                        Text(
                          dueDateText!,
                          style: TextStyle(
                              color: DateTime.now().isAfter(dueDate)
                                  ? Theme.of(context).colorScheme.error
                                  : Theme.of(context).colorScheme.onSurface),
                        )
                      ],
                    )
                  : SizedBox.shrink()
            ],
          ),
          trailing: Transform.scale(
            scale: 1.5, // Adjust the scale to make the checkbox larger
            child: SizedBox(
              height: 130,
              child: Checkbox(
                value: widget.todo.isComplete,
                onChanged: (newValue) async =>
                    widget.onIsCompleteChanged(widget.todo, newValue!),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
