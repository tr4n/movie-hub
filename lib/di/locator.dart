import 'package:get_it/get_it.dart';
import 'package:moviehub/data/platform/database/database.dart';
import 'package:moviehub/data/platform/network/api/api.dart';
import 'package:moviehub/data/repository/favorite_repository.dart';

import '../data/repository/repositories.dart';

final GetIt locator = GetIt.instance;

setupLocator() async {
  final appDatabase = await AppDatabase.getInstance();

  locator.registerLazySingleton(() => MovieApi());
  locator.registerLazySingleton<AppDatabase>(() => appDatabase);
  locator.registerLazySingleton(() => MovieRepository(locator<MovieApi>()));
  locator.registerLazySingleton(() {
    return FavoriteRepository(locator<AppDatabase>());
  });
}
