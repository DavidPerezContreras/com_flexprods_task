import 'package:flutter/material.dart';
import 'package:nested_navigation/data/todo/remote/DTO/create_todo_request_dto.dart';
import 'package:nested_navigation/data/todo/remote/DTO/update_todo_request_dto.dart';
import 'package:nested_navigation/domain/model/describable_error.dart';
import 'package:nested_navigation/domain/model/resource_state.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/presentation/global/offset.dart';
import 'package:nested_navigation/presentation/pages/save_todo/save_todo_page.dart';
import 'package:nested_navigation/presentation/widget/todo_list_card.dart';
import 'package:nested_navigation/provider/todo_provider.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
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

    final scaffoldMessenger = ScaffoldMessenger.of(context);
    scaffoldMessenger.showSnackBar(
      SnackBar(
        content: Text(errorMessage),
      ),
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
      _todoProvider.getTodoList();
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
      return Scaffold(
        body: Center(
            child: Container(
          height: 100,
          width: 100,
          child: CircularProgressIndicator(),
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: RefreshIndicator(
        onRefresh: _todoProvider.getTodoList,
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
