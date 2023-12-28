import 'package:flutter/material.dart';
import 'package:nested_navigation/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:nested_navigation/data/todo/remote/DTO/update_todo_request_dto.dart';
import 'package:nested_navigation/domain/model/todo.dart';

class SaveTodoPage<T> extends StatefulWidget {
  const SaveTodoPage({
    this.todo,
    super.key,
  });

  final Todo? todo;

  @override
  State<SaveTodoPage> createState() => _SaveTodoPageState<T>();
}

/*If we get a todo in the widget parameters, we load the form with that data,
*
* then
* We will just use Navigator.of(topLevelNavigationContext) with the new todo
* */
class _SaveTodoPageState<T> extends State<SaveTodoPage<T>> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo?.title ?? '');
    _descriptionController =
        TextEditingController(text: widget.todo?.description ?? '');
    _dueDate = widget.todo?.dueDate;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
            ),
            TextFormField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a description';
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select due date'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (T is CreateTodoRequest) {
                    Navigator.of(context)
                        .pop<CreateTodoRequest>(CreateTodoRequest(
                      title: _titleController.text,
                      description: _descriptionController.text,
                    ));
                  } else if (T is UpdateTodoRequest) {
                    Navigator.of(context).pop<UpdateTodoRequest>(
                      UpdateTodoRequest(
                        id: widget.todo!.id,
                        title: _titleController.text,
                        description: _descriptionController.text,
                        isComplete: widget.todo!.isComplete,
                        userId: widget.todo!.userId,
                        dueDate: _dueDate,
                      ),
                    );
                  }
                }
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
