import 'package:moviehub/blocs/base/base.dart';
import 'package:moviehub/data/model/movie.dart';

class HomeState extends BaseState {}

class HomeInitializedState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadSuccess extends HomeState {
  final List<Movie> trendingMovies;

  final List<Movie> tabMovies;

  @override
  List<Object?> get props => [trendingMovies, tabMovies];

  HomeLoadSuccess(this.trendingMovies, this.tabMovies);
}

class HomeLoadFailure extends HomeState {
  final dynamic error;

  HomeLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
