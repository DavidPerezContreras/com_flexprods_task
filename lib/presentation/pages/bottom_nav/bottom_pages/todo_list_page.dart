import 'package:flutter/material.dart';
import 'package:test/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:test/data/todo/remote/DTO/update_todo_request_dto.dart';
import 'package:test/domain/model/describable_error.dart';
import 'package:test/domain/model/resource_state.dart';
import 'package:test/domain/model/todo.dart';
import 'package:test/presentation/global/offset.dart';
import 'package:test/presentation/pages/save_todo/save_todo_page.dart';
import 'package:test/presentation/widget/todo_list_card.dart';
import 'package:test/provider/todo_provider.dart';
import 'package:test/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';

class TodoListPage extends StatefulWidget {
  const TodoListPage(this.onOffsetChanged, {super.key});

  final Function(double) onOffsetChanged;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  late ScrollController scrollController;
  late final TopLevelNavigationProvider _topLevelNavigationProvider;
  late final TodoProvider _todoProvider;

  bool _isLoading = true;

  void _showErrorMessage(DescribableError error, BuildContext context) async {
    String errorMessage = error.description;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(errorMessage),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
    _todoProvider = Provider.of<TodoProvider>(context, listen: false);
    scrollController = ScrollController(initialScrollOffset: offset);
    scrollController.addListener(() {
      widget.onOffsetChanged(scrollController.offset);
    });
    _todoList = _todoProvider.todoListState.data ?? [];
  }

  void _handleTodoStateChange() {
    ResourceState<List<Todo>> todoListResourceState =
        _todoProvider.todoListState;
    switch (todoListResourceState.status) {
      case Status.SUCCESS:
        _isLoading = false;
        _todoList = todoListResourceState.data!;
        break;
      case Status.LOADING:
        _isLoading = true;
        break;
      case Status.ERROR:
        _isLoading = false;
        _showErrorMessage(_todoProvider.todoListState.error!, context);
        break;
      default:
      //_todoList = [];
    }

    setState(() {});
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _todoProvider.addListener(_handleTodoStateChange);

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _todoProvider.getTodoList(loadAnimation: true);
    });
  }

  @override
  void dispose() {
    _todoProvider.removeListener(_handleTodoStateChange);
    super.dispose();
  }

  Future<void> _onIsCompleteChanged(Todo todo, bool newIsCompleteValue) async {
    _todoProvider.updateTodo(UpdateTodoRequest(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isComplete: !todo.isComplete,
    ));
  }

  void _createOnSave(
      {required String title, required String description, DateTime? dueDate}) {
    Navigator.of(_topLevelNavigationProvider
            .topLevelNavigation.currentState!.context)
        .pop<CreateTodoRequest>(CreateTodoRequest(
            title: title, description: description, dueDate: dueDate));
  }

  void _updateOnSave(Todo todo,
      {required String title, required String description, DateTime? dueDate}) {
    Navigator.of(_topLevelNavigationProvider
            .topLevelNavigation.currentState!.context)
        .pop<UpdateTodoRequest>(
      UpdateTodoRequest(
        id: todo.id,
        title: title,
        description: description,
        isComplete: todo.isComplete,
        dueDate: dueDate,
      ),
    );
  }

  late List<Todo> _todoList = [];

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(
            child: SizedBox(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        )),
      );
    }

    return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.onSecondary,
      appBar: AppBar(title: const Text('Tasks')),
      body: RefreshIndicator(
        onRefresh: () async {
          _todoProvider.getTodoList(loadAnimation: false);
        },
        child: LayoutBuilder(builder:
            (BuildContext buildContext, BoxConstraints boxConstraints) {
              var listwidth=boxConstraints.maxWidth-80;
              if( boxConstraints.maxWidth>600){
                listwidth=boxConstraints.maxWidth/1.69+40;
              }

              


          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: listwidth,
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  controller: scrollController,
                  itemCount: _todoList.length + 1,
                  itemBuilder: (context, index) {
                    if (index == _todoList.length) {
                      return const SizedBox(
                        height: 100,
                      );
                    }
                    Todo todo = _todoList[_todoList.length - index - 1];
                    return TodoListCard(
                        todo: todo,
                        onIsCompleteChanged: _onIsCompleteChanged,
                        onUpdate: _updateOnSave);
                  },
                ),
              )
            ],
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create task",
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.of(_topLevelNavigationProvider
                  .topLevelNavigation.currentState!.context)
              .push<CreateTodoRequest>(
            MaterialPageRoute(
              builder: (context) => SaveTodoPage.create(
                onCreate: _createOnSave,
              ),
            ),
          )
              .then((createTodoRequest) {
            if (createTodoRequest != null) {
              _todoProvider.createTodo(createTodoRequest);
            }
          });
        },
      ),
    );
  }
}
