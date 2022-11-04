import 'package:moviehub/blocs/base/base.dart';
import 'package:moviehub/data/model/models.dart';

class DetailState extends BaseState {}

class DetailInitializedState extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailLoadingMoreState extends DetailState {}

class DetailTabLoadingState extends DetailState {}

class DetailLoadedState extends DetailState {
  final int tabId;
  final Movie movie;
  final List<Review> reviews;
  final List<Cast> casts;

  final bool isLoadingMore;
  final bool isFavorite;

  @override
  List<Object?> get props =>
      [tabId, movie, reviews, casts, isLoadingMore, isFavorite];

  DetailLoadedState(
      {required this.movie,
      this.tabId = 0,
      this.reviews = const [],
      this.casts = const [],
      this.isLoadingMore = false,
      this.isFavorite = false});

  DetailLoadedState copyWith(
      {Movie? movie,
      int? tabId,
      List<Review>? reviews,
      List<Cast>? casts,
      bool? loading,
      bool? favorite}) {
    return DetailLoadedState(
        movie: movie ?? this.movie,
        tabId: tabId ?? this.tabId,
        reviews: reviews ?? this.reviews,
        casts: casts ?? this.casts,
        isLoadingMore: loading ?? isLoadingMore,
        isFavorite: favorite ?? isFavorite);
  }
}

class DetailLoadFailure extends DetailState {
  final dynamic error;

  DetailLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
