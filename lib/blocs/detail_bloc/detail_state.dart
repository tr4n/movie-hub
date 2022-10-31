import 'package:moviehub/blocs/base/base.dart';
import 'package:moviehub/data/model/movie.dart';

class DetailState extends BaseState {}

class DetailInitializedState extends DetailState {}

class DetailLoadingState extends DetailState {}

class DetailLoadingMoreState extends DetailState {}

class DetailLoadedState extends DetailState {
  final Movie movie;

  final bool isLoadingMore;

  @override
  List<Object?> get props => [movie, isLoadingMore];

  DetailLoadedState(this.movie, this.isLoadingMore);

  DetailLoadedState copyWith({Movie? movie, bool? loading}) {
    return DetailLoadedState(
      movie ?? this.movie,
      loading ?? isLoadingMore,
    );
  }
}

class DetailLoadFailure extends DetailState {
  final dynamic error;

  DetailLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
