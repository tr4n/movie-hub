import 'package:flutter/material.dart';
import 'package:moviehub/ui/screen/detail/detail_page.dart';
import 'package:moviehub/ui/screen/home/home_page.dart';
import 'package:moviehub/ui/screen/search/search_page.dart';
import 'package:moviehub/ui/screen/watch_list/watch_list_page.dart';

class Routes {
  Routes._();

  //screen name
  static const String splashScreen = "/splashScreen";
  static const String homeScreen = "/homeScreen";
  static const String searchScreen = "/searchScreen";
  static const String watchListScreen = "/watchListScreen";
  static const String detailScreen = "/detailScreen";

  //init screen name
  static String get initScreen => splashScreen;

  static final routes = <String, WidgetBuilder>{
    homeScreen: (context) => const HomePage(),
    searchScreen: (context) => const SearchPage(),
    watchListScreen: (context) => const WatchListPage(),
    // detailScreen: (context) => const DetailPage(),
  };
}
