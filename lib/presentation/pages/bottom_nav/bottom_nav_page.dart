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

class _BottomNavigationPageState extends State<BottomNavigationPage>
    with SingleTickerProviderStateMixin {
  late final ThemeProvider _themeProvider;
  late VoidCallback setThemeState;
  late TabController _tabController;

  void _onItemTapped(int index) {
    setState(() {
      _tabController.index=index;

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
    _tabController = TabController(length: 2, vsync: this);
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
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _themeProvider.seedColor,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 600) {
              // Wide screen: use top navigation
              return Column(
                children: [
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: IconButton(
                            icon: Image(
                                height: 40,
                                image: _themeProvider.isDarkMode
                                    ? const AssetImage(
                                        'assets/logo/bee_task_logo.png')
                                    : const AssetImage(
                                        'assets/logo/bee_task_logo.png')),
                            onPressed: () => {}),
                      ),
                      Container(
                        width: 300,
                        child: Container(
                          width: 300,
                          child: TabBar(
                            controller: _tabController,
                            onTap: (index) => _onItemTapped(index),
                            tabs: const [
                              Tab(icon: Icon(Icons.task,color: Colors.white,), child: Text("Tasks",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                              Tab(icon: Icon(Icons.task,color: Colors.white,), child: Text("Settings",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        _generateBody(0),
                        _generateBody(1),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              // Narrow screen: use bottom navigation
              return _generateBody(_tabController.index);
            }
          },
        ),
      ),
      bottomNavigationBar: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return SizedBox.shrink(); // Hide bottom navigation on wide screens
          } else {
            return BottomNavigationBar(
              currentIndex: _tabController.index,
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
            );
          }
        },
      ),
    );
  }
}
