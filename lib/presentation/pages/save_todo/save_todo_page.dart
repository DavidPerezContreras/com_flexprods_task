import 'package:flutter/material.dart';
import 'package:nested_navigation/domain/model/todo.dart';

class SaveTodoPage extends StatefulWidget {
  const SaveTodoPage({this.todo, super.key});

  final Todo? todo;

  @override
  State<SaveTodoPage> createState() => _SaveTodoPageState();
}

/*Whoever pushed to this place, will know it its editing or creating,
* We can know it too if the widget.todo is null
*
* We will just use Navigator.of(topLevelNavigationContext) with the new todo
* */
class _SaveTodoPageState extends State<SaveTodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.red,
      ),
    );
  }
}
