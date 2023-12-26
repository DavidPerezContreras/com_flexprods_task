import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/global/offset.dart';
import 'package:nested_navigation/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  const TaskListScreen(this.onOffsetChanged, {super.key});

  final Function(double) onOffsetChanged;
  @override
  State<TaskListScreen> createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  late ScrollController scrollController;

  late AuthProvider _authProvider;

  @override
  void initState() {
    _authProvider = Provider.of<AuthProvider>(context, listen: false);
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
        onPressed: () {
          setState(() {
            _authProvider.logout();
          });
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
