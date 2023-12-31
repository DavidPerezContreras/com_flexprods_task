import 'package:flutter/material.dart';
import 'package:nested_navigation/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late final BottomNavigationProvider _bottomNavigationProvider;

  @override
  void initState() {
    super.initState();
    _bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Consumer<BottomNavigationProvider>(
          builder: (context, provider, child) {
            return Navigator(
              key: provider.nestedNavigation,
              pages: [provider.activePage],
              onPopPage: (route, result) {
                print("onPopPage BOTTOMNAV");
                return false;
              },
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavigationProvider.selectedIndex,
        onTap: (newIndex) async {
          _bottomNavigationProvider.updateIndex(newIndex);
          setState(() {});
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
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        iconSize: 24,
        selectedFontSize: 14,
        unselectedFontSize: 12,
        selectedIconTheme: const IconThemeData(size: 28),
      ),
    );
  }
}
