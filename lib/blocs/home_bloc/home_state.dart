import 'package:moviehub/blocs/base/base.dart';
import 'package:moviehub/data/model/movie.dart';

class HomeState extends BaseState {}

class HomeInitializedState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadingMoreState extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<Movie> trendingMovies;

  final List<Movie> tabMovies;

  final bool isLoadingMore;

  @override
  List<Object?> get props => [trendingMovies, tabMovies, isLoadingMore];

  HomeLoadSuccess(this.trendingMovies, this.tabMovies, this.isLoadingMore);

  HomeLoadSuccess copyWith(
      {List<Movie>? trendingMovies, List<Movie>? tabMovies, bool? loading}) {
    return HomeLoadSuccess(
      trendingMovies ?? this.trendingMovies,
      tabMovies ?? this.tabMovies,
      loading ?? isLoadingMore,
    );
  }
}

class HomeLoadFailure extends HomeState {
  final dynamic error;

  HomeLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
