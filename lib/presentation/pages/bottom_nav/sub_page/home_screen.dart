import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/global/offset.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen(this.onOffsetChanged, {super.key});

  final Function(double) onOffsetChanged;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: offset);
    scrollController.addListener(() {
      widget.onOffsetChanged(scrollController.offset);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<BottomNavigationProvider>(context);

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
          setState(() {});
        },
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}
