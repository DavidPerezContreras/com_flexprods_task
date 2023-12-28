import 'package:flutter/material.dart';
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
    _todoProvider.addListener(() {
      ResourceState<List<Todo>> todoListResourceState =
          _todoProvider.todoListState;
      switch (todoListResourceState.status) {
        case Status.SUCCESS:
          _todoList = todoListResourceState.data!;
          break;
        default:
        //_todoList = [];
      }
      if (mounted) {
        setState(() {});
      }
    });
    Future.microtask(() => _todoProvider.getTodoList());
  }

  void _onIsCompleteChanged(Todo todo, bool newIsCompleteValue) {
    setState(() {
      _todoList = _todoList.map((item) {
        if (item.id == todo.id) {
          return item.copyWith(isComplete: newIsCompleteValue);
        }
        return item;
      }).toList();
    });
  }

  late List<Todo> _todoList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
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

            return TodoListCard(
              todo: _todoList[_todoList.length - index - 1],
              onIsCompleteChanged: _onIsCompleteChanged,
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create task",
        child: const Icon(Icons.add),
        onPressed: () async {

          _todoList.add(await _todoProvider.);

          Navigator.of(_topLevelNavigationProvider
                  .topLevelNavigation.currentState!.context)
              .push(
            MaterialPageRoute(
              builder: (context) => const SaveTodoPage(),
            ),
          );
        },
      ),
    );
  }
}
