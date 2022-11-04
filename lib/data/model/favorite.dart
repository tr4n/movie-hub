import 'package:floor/floor.dart';

@entity
class Favorite {
  @primaryKey
  @ColumnInfo(name: "id")
  int id = 0;
  @ColumnInfo(name: "title")
  String title = "";
  @ColumnInfo(name: "voteAverage")
  double voteAverage = 0.0;
  @ColumnInfo(name: "genes")
  String genes = "";
  @ColumnInfo(name: "releaseYear")
  String releaseYear = "";
  @ColumnInfo(name: "runTime")
  int runTime = 0;
  @ColumnInfo(name: "posterPath")
  String posterPath = "";

  Favorite(
      {this.id = 0,
      this.title = "",
      this.voteAverage = 0.0,
      this.genes = "",
      this.releaseYear = "",
      this.runTime = 0,
      this.posterPath = ""});
}
