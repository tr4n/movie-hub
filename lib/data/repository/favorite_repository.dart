import 'package:moviehub/data/model/favorite.dart';
import 'package:moviehub/data/platform/database/database.dart';

class FavoriteRepository {
  final AppDatabase database;

  FavoriteRepository(this.database);

  Future<List<Favorite>> getFavorites() {
    return database.favoriteDao.getAll();
  }

  Future<void> addFavorite(Favorite favorite) {
    return database.favoriteDao.insert(favorite);
  }

  Future<void> removeFavorite(int id) {
    return database.favoriteDao.delete(id);
  }

  Future<Favorite?> getFavorite(int id) {
    return database.favoriteDao.get(id);
  }
}
