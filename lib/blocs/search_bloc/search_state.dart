import 'package:moviehub/blocs/base/base.dart';
import 'package:moviehub/data/model/models.dart';

class SearchState extends BaseState {}

class SearchInitializedState extends SearchState {}

class SearchLoadingState extends SearchState {}

class SearchLoadingMoreState extends SearchState {}

class SearchTabLoadingState extends SearchState {}

class SearchLoadedState extends SearchState {
  final List<Movie> movies;

  final bool isLoadingMore;

  @override
  List<Object?> get props => [movies, isLoadingMore];

  SearchLoadedState({this.movies = const [], this.isLoadingMore = false});

  SearchLoadedState copyWith({List<Movie>? movies, bool? loading}) {
    return SearchLoadedState(
      movies: movies ?? this.movies,
      isLoadingMore: loading ?? isLoadingMore,
    );
  }
}

class SearchLoadFailure extends SearchState {
  final dynamic error;

  SearchLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
