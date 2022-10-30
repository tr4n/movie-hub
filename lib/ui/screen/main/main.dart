import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviehub/extension/context_ext.dart';
import 'package:moviehub/ui/components/components.dart';

import '../../../di/locator.dart';
import '../../../resources/resources.dart';
import '../home/home_page.dart';
import '../search/search_page.dart';
import '../watch_list/watch_list_page.dart';

void main() {
  setupLocator();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      // Change it as you want
      theme: ThemeData(
          fontFamily: "Open Sans",
          primaryColor: Colors.white,
          brightness: Brightness.light,
          primaryColorDark: Colors.black,
          canvasColor: Colors.white,
          appBarTheme:
              const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark)),
      darkTheme: ThemeData(
          fontFamily: "Open Sans",
          primaryColor: AppColor.gray242A32,
          primaryColorLight: AppColor.gray242A32,
          brightness: Brightness.dark,
          primaryColorDark: AppColor.gray242A32,
          indicatorColor: Colors.white,
          canvasColor: AppColor.gray242A32,
          // next line is important!
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light)),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});
  final String title;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  final _screens = [
    ScreenTab(
      index: 0,
      page: HomePage(),
      name: "Home",
      title: "What do you want to watch?",
      icon: "assets/icons/ic_home.png",
    ),
    ScreenTab(
      index: 1,
      name: "Search",
      page: SearchPage(),
      title: "Search",
      icon: "assets/icons/ic_search.png",
    ),
    ScreenTab(
      index: 2,
      name: "Watch List",
      page: WatchListPage(),
      title: 'Watch List',
      icon: "assets/icons/ic_book_mark.png",
    ),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _getSelectedColor(int index) {
    return _selectedIndex == index
        ? AppColor.blue0296E5
        : AppColor.gray67686D;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: _selectedIndex > 2
            ? Padding(
                padding: const EdgeInsets.all(Sizes.size8),
                child: Image.asset("assets/icons/ic_left_arrow.png",
                    width: Sizes.size20, height: Sizes.size20))
            : null,
        centerTitle: _selectedIndex != 0,
        actions: _selectedIndex > 2
            ? [
                Image.asset("assets/icons/ic_information.png",
                    width: 36, height: 36),
              ]
            : null,
        title: DefaultTextStyle(
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          child: Text(_screens[_selectedIndex].title),
        ),
        backgroundColor: AppColor.gray242A32,
        elevation: 0,
      ),
      body: _screens[_selectedIndex].page,
      bottomNavigationBar: Wrap(children: [
        Container(
          width: context.getWidth(),
          height: 1.0,
          color: AppColor.blue0296E5,
        ),
        BottomNavigationBar(
          items: _screens
              .map(
                (screen) => BottomNavigationBarItem(
                  icon: Padding(
                    padding: const EdgeInsets.all(Sizes.size8),
                    child: Image.asset(
                      screen.icon,
                      width: 24,
                      height: 24,
                      color: _getSelectedColor(screen.index),
                    ),
                  ),
                  label: screen.name,
                ),
              )
              .toList(),
          onTap: _onItemTap,
          currentIndex: _selectedIndex,
          selectedItemColor: AppColor.blue0296E5,
        ),
      ]),
    );
  }
}
