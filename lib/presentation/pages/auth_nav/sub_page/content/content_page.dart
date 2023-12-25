import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/global/offset.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/home_screen.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/sub_page/second_screen.dart';
import 'package:nested_navigation/presentation/pages/auth_nav/sub_page/content/provider/bottom_navigation_provider.dart';
import 'package:provider/provider.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({super.key});

  @override
  State<ContentPage> createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var pages = [
      HomeScreen((newOffset) {
        onOffsetChanged(newOffset);
      }),
      const SecondScreen()
    ];

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
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business),
                label: 'Business',
              ),
            ],
          ),
        );
      },
    );
  }
}
