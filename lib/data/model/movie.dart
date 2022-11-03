import 'package:json_annotation/json_annotation.dart';

import 'models.dart';

part 'movie.g.dart';

@JsonSerializable()
class Movie {
  @JsonKey(name: "id")
  int id = 0;
  @JsonKey(name: "poster_path")
  String? posterPath = "";
  @JsonKey(name: "overview")
  String? overview = "";
  @JsonKey(name: "release_date")
  String? releaseDate = "";
  @JsonKey(name: "original_title")
  String? originalTitle = "";
  @JsonKey(name: "original_language")
  String? originalLanguage;
  @JsonKey(name: "title")
  String? title = "";
  @JsonKey(name: "backdrop_path")
  String? backdropPath;
  @JsonKey(name: "popularity")
  double popularity = 0.0;
  @JsonKey(name: "vote_count")
  int voteCount = 0;
  @JsonKey(name: "vote_average")
  double voteAverage = 0.0;
  @JsonKey(name: "runtime")
  int? runtime = 0;
  @JsonKey(name: "genres")
  List<Genre>? genres = List.empty();

  Movie();

  String getReleaseYear() => releaseDate?.substring(0, 4) ?? "";

  String listGenresString() => genres?.map((e) => e.name ).join(", ") ?? "";

  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}
