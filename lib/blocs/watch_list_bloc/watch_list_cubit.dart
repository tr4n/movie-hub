import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/watch_list_bloc/watch_list_state.dart';
import 'package:moviehub/data/repository/favorite_repository.dart';

import '../../common/error_handler.dart';
import '../../di/locator.dart';

class WatchListCubit extends Cubit<WatchListState> {
  final FavoriteRepository _favoriteRepository = locator<FavoriteRepository>();

  WatchListCubit() : super(WatchListInitializedState());

  Future<void> getWatchList() async {
    emit(WatchListLoadingState());

    try {
      final favorites = await _favoriteRepository.getFavorites();
      emit(WatchListLoadedState(favorites: favorites));
    } catch (exception) {
      final response = handelError(exception);
      emit(WatchListLoadFailure(response));
    }
  }
}
