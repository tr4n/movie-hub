import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/search_bloc/search_state.dart';
import 'package:moviehub/common/common.dart';

import '../../common/error_handler.dart';
import '../../data/repository/repositories.dart';
import '../../di/locator.dart';

class SearchCubit extends Cubit<SearchState> {
  int _currentPage = 0;
  int _totalPage = 0;
  String _query = "";
  final MovieRepository _movieRepository = locator<MovieRepository>();

  SearchCubit() : super(SearchInitializedState());

  Future<void> search(String query) async {
    if (_query == query && _currentPage >= _totalPage) {
      return;
    }
    emit(SearchLoadingState());
    if (_query != query) {
      _currentPage = 0;
      _query = query;
      emit(SearchLoadedState());
    }
    final loadedState = cast<SearchLoadedState>(state);
    if (loadedState == null) return;
    try {
      final response =
          await _movieRepository.searchMovies(query, _currentPage + 1);
      _totalPage = response.totalPages;
      _currentPage = response.page;
      emit(loadedState.copyWith(
        movies: loadedState.movies + response.results,
        loading: false,
      ));
    } catch (exception) {
      final response = handelError(exception);
      emit(SearchLoadFailure(response));
    }
  }
}
