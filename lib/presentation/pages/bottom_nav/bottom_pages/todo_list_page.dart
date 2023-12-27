import 'package:flutter/material.dart';
import 'package:nested_navigation/domain/model/todo.dart';
import 'package:nested_navigation/presentation/global/offset.dart';
import 'package:nested_navigation/presentation/pages/save_todo/save_todo_page.dart';
import 'package:nested_navigation/presentation/widget/todo_list_card.dart';
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

  @override
  void initState() {
    super.initState();
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
    scrollController = ScrollController(initialScrollOffset: offset);
    scrollController.addListener(() {
      widget.onOffsetChanged(scrollController.offset);
    });
    todoList=List.generate(todoListLength, (index) => Todo(
        id: index,
        title: "This is the item number $index",
        description:
        "This is the description of the item $index aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
        isComplete: false,
        userId: 1),

    );
  }

  void _onIsCompleteChanged(Todo todo, bool newIsCompleteValue) {
    setState(() {
      todoList = todoList.map((item) {
        if (item.id == todo.id) {
          return item.copyWith(isComplete: newIsCompleteValue);
        }
        return item;
      }).toList();
    });

  }
  late List<Todo> todoList;
  int todoListLength = 100;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        controller: scrollController,
        itemCount: todoListLength + 1,
        itemBuilder: (context, index) {
          if (index == todoListLength) {
            return const SizedBox(
              height: 100,
            );
          }

          return TodoListCard(
            todo: todoList[index], onIsCompleteChanged: _onIsCompleteChanged,);
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create task",
        child: const Icon(Icons.add),
        onPressed: () async {
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
