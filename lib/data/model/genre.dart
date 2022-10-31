import 'package:json_annotation/json_annotation.dart';

part 'genre.g.dart';

@JsonSerializable()
class Genre {
  @JsonKey(name: "id")
  int id = 0;
  @JsonKey(name: "name")
  String name = "";

  Genre();

  factory Genre.fromJson(Map<String, dynamic> json) => _$GenreFromJson(json);
}
