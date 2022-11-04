import 'package:floor/floor.dart';

import '../../model/favorite.dart';

@dao
abstract class FavoriteDao {
  @Query("SELECT * FROM favorite")
  Future<List<Favorite>> getAll();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(Favorite favorite);

  @Query("DELETE FROM favorite WHERE id = :id")
  Future<void> delete(int id);

  @Query("SELECT * FROM favorite WHERE id = :id")
  Future<Favorite?> get(int id);

  @Update()
  Future<void> update(Favorite favorite);
}
