import 'dart:async';

import 'package:floor/floor.dart';
import 'package:moviehub/data/model/favorite.dart';
import 'package:moviehub/data/platform/database/favorite_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Favorite])
abstract class AppDatabase extends FloorDatabase {

  FavoriteDao get favoriteDao;

  static Future<AppDatabase> getInstance() async {
    return $FloorAppDatabase.databaseBuilder("movie_hub.db").build();
  }
}
