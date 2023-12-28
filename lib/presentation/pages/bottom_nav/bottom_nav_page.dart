import 'package:flutter/material.dart';
import 'package:nested_navigation/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  ScrollController scrollController = ScrollController();
  late final _bottomNavigationProvider;
  @override
  void initState() {
    super.initState();
    _bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Navigator(
        key: _bottomNavigationProvider.nestedNavigation,
        pages: [_bottomNavigationProvider.activePage],
        onPopPage: (route, result) {
          print("onPopPage BOTTOMNAV");
          return false;
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavigationProvider.selectedIndex,
        onTap: (newIndex) {
          setState(() {
            _bottomNavigationProvider.updateIndex(newIndex);
          });
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
        type: BottomNavigationBarType
            .fixed, // This will help in giving a neat look when you have more than 3 items
        elevation: 8, // This will give a shadow to the bar
        iconSize: 24, // You can adjust the icon size here
        selectedFontSize: 14, // Adjust selected font size
        unselectedFontSize: 12, // Adjust unselected font size
        selectedIconTheme: IconThemeData(
            size:
                28), // This will give a slight zoom effect to the selected item's icon
      ),
    );
  }
}
