import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/auth_level_pages/top_level_nav/top_level_pages/bottom_nav/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationProvider>(
      builder: (BuildContext context, bottomNavigationProvider, Widget? child) {
        return Scaffold(
          body: Navigator(
            key: bottomNavigationProvider.nestedNavigation,
            pages: [bottomNavigationProvider.activePage],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }
              // Update the list of pages
              return true;
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: bottomNavigationProvider.selectedIndex,
            onTap: (newIndex) {
              bottomNavigationProvider.updateIndex(newIndex);
            },
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Tasks",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        );
      },
    );
  }
}
