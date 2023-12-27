import 'package:flutter/material.dart';

class SaveTodoPage extends StatefulWidget {
  const SaveTodoPage({super.key});

  @override
  State<SaveTodoPage> createState() => _SaveTodoPageState();
}

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
