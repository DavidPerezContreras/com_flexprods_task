import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/provider/top_level_navigation_provider.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/bottom_nav/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/save_todo/save_todo_page.dart';
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
    _topLevelNavigationProvider =
        Provider.of<TopLevelNavigationProvider>(context, listen: false);
    scrollController = ScrollController(initialScrollOffset: offset);
    scrollController.addListener(() {
      widget.onOffsetChanged(scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView.builder(
        controller: scrollController,
        itemCount: 100,
        itemBuilder: (context, index) {
          return ListTile(title: Text('Item $index'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create task",
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(_topLevelNavigationProvider
                  .topLevelNavigation.currentState!.context)
              .push(MaterialPageRoute(
            builder: (context) {
              return const SaveTodoPage();
            },
          ));
          //_authProvider.logout();
        },
      ),
    );
  }
}
