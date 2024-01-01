import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/global/offset.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_pages/settings_page.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/bottom_pages/todo_list_page.dart';
import 'package:nested_navigation/provider/bottom_navigation_provider.dart';
import 'package:nested_navigation/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late final ThemeProvider _themeProvider;
  late VoidCallback setThemeState;

  PageController _pageController = PageController(initialPage: 0);
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    setThemeState = () {
      setState(() {});
    };

    _themeProvider.addListener(setThemeState);
  }

  @override
  void dispose() {
    super.dispose();
    _themeProvider.removeListener(setThemeState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _themeProvider.seedColor,
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (newIndex) {
            _selectedIndex = newIndex;
            //setState(() {});
          },
          children: [
            TodoListPage((newOffset) {
              onOffsetChanged(newOffset);
            }),
            SettingsPage()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (newIndex) async {
          _selectedIndex = newIndex;
          _pageController.animateToPage(newIndex,
              duration: Duration(milliseconds: 300), curve: Curves.linear);

          //setState(() {});
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
