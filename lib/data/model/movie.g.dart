// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie()
  ..id = json['id'] as int
  ..posterPath = json['poster_path'] as String?
  ..overview = json['overview'] as String?
  ..releaseDate = json['release_date'] as String?
  ..originalTitle = json['original_title'] as String?
  ..originalLanguage = json['original_language'] as String?
  ..title = json['title'] as String?
  ..backdropPath = json['backdrop_path'] as String?
  ..popularity = (json['popularity'] as num).toDouble()
  ..voteCount = json['vote_count'] as int
  ..voteAverage = (json['vote_average'] as num).toDouble()
  ..runtime = json['runtime'] as int?
  ..genres = (json['genres'] as List<dynamic>?)
      ?.map((e) => Genre.fromJson(e as Map<String, dynamic>))
      .toList();

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'poster_path': instance.posterPath,
      'overview': instance.overview,
      'release_date': instance.releaseDate,
      'original_title': instance.originalTitle,
      'original_language': instance.originalLanguage,
      'title': instance.title,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_count': instance.voteCount,
      'vote_average': instance.voteAverage,
      'runtime': instance.runtime,
      'genres': instance.genres,
    };
