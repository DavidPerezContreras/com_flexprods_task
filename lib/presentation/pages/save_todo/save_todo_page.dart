import 'package:flutter/material.dart';
import 'package:test/domain/model/todo.dart';

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
    final String selectedDateText = _dueDate == null
        ? "No date selected"
        : "Selected date:   ${_dueDate!.day} / ${_dueDate!.month} / ${_dueDate!.year}";

    return Scaffold(
      appBar: AppBar(title: Text(widget.onCreate==null?"Edit Task":"Create Task",style: TextStyle(fontFamily: ""),), ),
      body: Form(
        key: _formKey,
        child: SafeArea(

            child:            Flexible(
              flex: 8,
              child: LayoutBuilder(builder:
            (BuildContext buildContext, BoxConstraints boxConstraints) {
              var listwidth=boxConstraints.maxWidth-80;
              if( boxConstraints.maxWidth>600){
                listwidth=boxConstraints.maxWidth/1.69+40;
              }

                return SingleChildScrollView(


                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: listwidth,
                          child: ListView(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            padding: const EdgeInsets.all(16.0),
                            children: <Widget>[
                              TextFormField(
                                maxLength: 256,
                                controller: _titleController,
                                decoration: InputDecoration(
                                  labelText: 'Title',
                                  labelStyle: TextStyle(
                                      color: Theme.of(context).colorScheme.onSurface),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color:
                                            Theme.of(context).colorScheme.secondary),
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
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter a title';
                                  } else if (value.length > 256) {
                                    return 'Title cannot be more than 256 characters';
                                  }
                                  return null;
                                },
                              ),
                              const Divider(color: Colors.transparent, height: 20),
                              SizedBox(
                                height: 225,
                                child: TextFormField(
                                  maxLength: 256,
                                  controller: _descriptionController,
                                  decoration: InputDecoration(
                                    labelText: 'Description',
                                    labelStyle: TextStyle(
                                        color:
                                            Theme.of(context).colorScheme.onSurface),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context)
                                              .colorScheme
                                              .secondary),
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
                                          color:
                                              Theme.of(context).colorScheme.primary),
                                    ),
                                  ),
                                  keyboardType: TextInputType.multiline,
                                  maxLines: null,
                                  validator: (value) {
                                    if (value!.length > 256) {
                                      return 'Description cannot be more than 256 characters';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const Divider(color: Colors.transparent, height: 20),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                                child: Column(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () => _selectDate(context),
                                      child: const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Select due date'),
                                          Icon(Icons.calendar_month)
                                        ],
                                      ),
                                    ),
                                    Text(selectedDateText)
                                  ],
                                ),
                              ),
                              //Divider(
                              //    color: Colors.transparent,
                              //    height: viewportConstraints.maxHeight*0.4),
                          
                              Padding(
                                padding: const EdgeInsets.all(50.0),
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    side: const BorderSide(
                                        color: Colors.black38,
                                        width:
                                            2), // change the color and width as needed
                                    minimumSize: const Size(
                                        200, 60), // change the size as needed
                                  ),
                                  child: const Text(
                                    "Save",
                                    style: TextStyle(
                                      fontSize: 20, // change the font size as needed
                                    ),
                                  ),
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
                                              description:
                                                  _descriptionController.text,
                                              dueDate: _dueDate);
                                        }
                                      }
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  
                );
              }),
            ),
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
