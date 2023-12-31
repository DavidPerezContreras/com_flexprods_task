import 'package:flutter/material.dart';
import 'package:nested_navigation/domain/model/todo.dart';

class SaveTodoPage extends StatefulWidget {
  const SaveTodoPage.create({
    required this.onCreate,
    super.key,
  })  : todo = null,
        onUpdate = null;

  const SaveTodoPage.update({
    required this.todo,
    required this.onUpdate,
    super.key,
  }) : onCreate = null;

  final Todo? todo;

  @override
  State<SaveTodoPage> createState() => _SaveTodoPageState();

  final Function({
    required String title,
    required String description,
    DateTime? dueDate,
  })? onCreate;

  final Function(
    Todo todo, {
    required String title,
    required String description,
    DateTime? dueDate,
  })? onUpdate;
}

class _SaveTodoPageState extends State<SaveTodoPage> {
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
      body: LayoutBuilder(builder: (context, boxConstraints) {
        return Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  labelStyle:
                      TextStyle(color: Theme.of(context).colorScheme.onSurface),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.error),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).colorScheme.error),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  } else if (value.length > 256) {
                    return 'Title cannot be more than 256 characters';
                  }
                  return null;
                },
              ),
              Divider(color: Colors.transparent, height: 20),
              Container(
                height: 100,
                child: TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.secondary),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.error),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    } else if (value.length > 256) {
                      return 'Description cannot be more than 256 characters';
                    }
                    return null;
                  },
                ),
              ),
              Divider(color: Colors.transparent, height: 20),
              ElevatedButton(
                onPressed: () => _selectDate(context),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Select due date'),
                    Icon(Icons.calendar_month)
                  ],
                ),
              ),
              Divider(color: Colors.transparent, height: 100),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    if (widget.onCreate != null) {
                      widget.onCreate!(
                          title: _titleController.text,
                          description: _descriptionController.text,
                          dueDate: _dueDate);
                    } else {
                      if (widget.onUpdate != null) {
                        widget.onUpdate!(widget.todo!,
                            title: _titleController.text,
                            description: _descriptionController.text,
                            dueDate: _dueDate);
                      }
                    }
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        );
      }),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
