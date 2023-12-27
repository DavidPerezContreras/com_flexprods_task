import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/global/offset.dart';
import 'package:nested_navigation/presentation/pages/save_todo/save_todo_page.dart';
import 'package:nested_navigation/presentation/widget/todo_list_card.dart';
import 'package:nested_navigation/provider/top_level_navigation_provider.dart';
import 'package:provider/provider.dart';

import '../../../../domain/model/todo.dart';

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
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
    scrollController = ScrollController(initialScrollOffset: offset);
    scrollController.addListener(() {
      widget.onOffsetChanged(scrollController.offset);
    });
    super.initState();
  }

  int todoListLength=100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body:
        ListView.builder(
          controller: scrollController,
          itemCount: todoListLength+1,
          itemBuilder: (context, index) {
            if(index==todoListLength){
              return const SizedBox(height: 100,);
            }

            return TodoListCard(
              todo: Todo(
                  id: index,
                  title: "This is the item number $index",
                  description: "This is the description of the item $index aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
                  isComplete: false,
                  userId: 1),
            );
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
