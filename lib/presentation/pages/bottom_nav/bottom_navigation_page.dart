import 'package:flutter/material.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/global/offset.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/sub_page/home_screen.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/sub_page/second_screen.dart';
import 'package:nested_navigation/presentation/pages/bottom_nav/provider/bottom_navigation_provider.dart';
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
    final bottomNavigationProvider =
        Provider.of<BottomNavigationProvider>(context);

    var pages = [
      HomeScreen((newOffset) {
        onOffsetChanged(newOffset);
      }),
      const SecondScreen()
    ];

    return Scaffold(
      body: Navigator(
        key: bottomNavigationProvider.nestedNavigation,
        pages: bottomNavigationProvider.activePage,
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
          setState(() {
            bottomNavigationProvider
                .navigate(MaterialPage(child: pages[newIndex]));
            bottomNavigationProvider.updateIndex(newIndex);
          });
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
  }
}
