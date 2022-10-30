import 'package:get_it/get_it.dart';
import 'package:moviehub/data/platform/network/api/api.dart';

import '../data/repository/repositories.dart';

final GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => MovieApi());
  locator.registerLazySingleton(() => MovieRepository(locator<MovieApi>()));
}
