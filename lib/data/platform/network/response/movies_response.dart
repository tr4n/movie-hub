import 'package:json_annotation/json_annotation.dart';
import 'package:moviehub/data/model/movie.dart';

part 'movies_response.g.dart';

@JsonSerializable()
class MoviesResponse {
  @JsonKey(name: "page")
  int page = 0;
  @JsonKey(name: "total_pages")
  int totalPages = 0;
  @JsonKey(name: "total_results")
  int totalResults = 0;
  @JsonKey(name: "results")
  List<Movie> results = List.empty();

  MoviesResponse();

  factory MoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$MoviesResponseFromJson(json);
}
