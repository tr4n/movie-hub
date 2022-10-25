import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviehub/extension/context_ext.dart';
import 'package:moviehub/ui/components/components.dart';
import 'package:moviehub/ui/home/home_page.dart';
import 'package:moviehub/ui/search/search_page.dart';
import 'package:moviehub/ui/watch_list/watch_list_page.dart';

import '../resources/resources.dart';

void main() {
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
          primaryColor: AppColor.colorGray242A32,
          primaryColorLight: AppColor.colorGray242A32,
          brightness: Brightness.dark,
          primaryColorDark: AppColor.colorGray242A32,
          indicatorColor: Colors.white,
          canvasColor: AppColor.colorGray242A32,
          // next line is important!
          appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle.light)),
      home: const MainPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      icon: "assets/icons/ic_home.png",
    ),
    ScreenTab(
      index: 2,
      name: "Watch List",
      page: WatchListPage(),
      title: 'Watch List',
      icon: "assets/icons/ic_home.png",
    ),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Color _getSelectedColor(int index) {
    return _selectedIndex == index
        ? AppColor.colorBlue0296E5
        : AppColor.colorGray67686D;
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
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          child: Text(_screens[_selectedIndex].title),
        ),
        backgroundColor: AppColor.colorGray242A32,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Wrap(children: [
        Container(
          width: context.getWidth(),
          height: 1.0,
          color: const Color(0xff0296E5),
        ),
        BottomNavigationBar(
          items: _screens
              .map((screen) => BottomNavigationBarItem(
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
                  ))
              .toList(),
          onTap: _onItemTap,
          selectedItemColor: AppColor.colorBlue0296E5,
        ),
      ]),
    );
  }
}
