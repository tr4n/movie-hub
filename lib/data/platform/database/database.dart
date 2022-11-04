import 'dart:async';

import 'package:floor/floor.dart';
import 'package:moviehub/data/model/favorite.dart';
import 'package:moviehub/data/platform/database/favorite_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [Favorite])
abstract class AppDatabase extends FloorDatabase {
  // static AppDatabase? instance;

  FavoriteDao get favoriteDao;

  // static get instance async {
  //   return _database ??= await _$AppDatabaseBuilder("movie_hub.db").build();
  // }

  static Future<AppDatabase> getInstance() {
    return $FloorAppDatabase.databaseBuilder("movie_hub.db").build();
  }
}
