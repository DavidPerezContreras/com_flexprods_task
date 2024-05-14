import 'package:flutter/material.dart';
import 'package:test/presentation/global/offset.dart';
import 'package:test/presentation/pages/bottom_nav/bottom_pages/settings_page.dart';
import 'package:test/presentation/pages/bottom_nav/bottom_pages/todo_list_page.dart';
import 'package:test/provider/theme_provider.dart';
import 'package:provider/provider.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({super.key});

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  late final ThemeProvider _themeProvider;
  late VoidCallback setThemeState;

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _generateBody(int index) {
    Widget body;
    switch (index) {
      case 0:
        body = TodoListPage((newOffset) {
          onOffsetChanged(newOffset);
        });
        break;
      case 1:
        body = const SettingsPage();
        break;
      default:
        body = const Scaffold();
    }
    return body;
  }

  @override
  void initState() {
    super.initState();
    _themeProvider = Provider.of<ThemeProvider>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
      body: SafeArea(child: _generateBody(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (newIndex) async {
          _onItemTapped(newIndex);
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.task),
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
