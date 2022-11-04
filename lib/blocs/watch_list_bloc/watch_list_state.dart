import 'package:moviehub/blocs/base/base.dart';
import 'package:moviehub/data/model/models.dart';

class WatchListState extends BaseState {}

class WatchListInitializedState extends WatchListState {}

class WatchListLoadingState extends WatchListState {}

class WatchListLoadingMoreState extends WatchListState {}

class WatchListTabLoadingState extends WatchListState {}

class WatchListLoadedState extends WatchListState {
  final List<Favorite> favorites;

  @override
  List<Object?> get props => [favorites];

  WatchListLoadedState({this.favorites = const []});

  WatchListLoadedState copyWith({List<Favorite>? movies}) {
    return WatchListLoadedState(
      favorites: movies ?? favorites,
    );
  }
}

class WatchListLoadFailure extends WatchListState {
  final dynamic error;

  WatchListLoadFailure(this.error);

  @override
  List<Object> get props => [error];
}
