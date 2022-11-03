import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/detail_bloc/detail_state.dart';
import 'package:moviehub/common/common.dart';

import '../../common/error_handler.dart';
import '../../common/type/detail_tab.dart';
import '../../data/repository/repositories.dart';
import '../../di/locator.dart';

class DetailCubit extends Cubit<DetailState> {
  int _currentPage = 0;
  int _totalPage = 0;
  final MovieRepository _movieRepository = locator<MovieRepository>();

  DetailCubit() : super(DetailInitializedState());

  Future<void> loadDataFirstTime(int id) async {
    emit(DetailLoadingState());

    try {
      final movie = await _movieRepository.getDetailMovie(id);
      emit(DetailLoadedState(movie: movie));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }

  Future<void> loadReviewData(int id) async {
    final loadedState = cast<DetailLoadedState>(state);
    if (loadedState == null || _currentPage >= _totalPage) {
      return;
    }
    emit(loadedState.copyWith(loading: true));
    try {
      final response =
          await _movieRepository.getMovieReviews(id, _currentPage + 1);
      final reviews = response.results ?? List.empty();
      if (reviews.isNotEmpty) {
        _currentPage = _currentPage + 1;
      }

      emit(loadedState.copyWith(
          reviews: loadedState.reviews + reviews, loading: false));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }

  Future<void> changeTab(int id, int type) async {
    final loadedState = cast<DetailLoadedState>(state);
    if (loadedState == null) return;
    try {
      if (type == DetailTab.reviews.id) {
        final response = await _movieRepository.getMovieReviews(id, 1);
        final reviews = response.results ?? List.empty();
        _currentPage = response.page ?? 1;
        _totalPage = response.totalPages ?? 0;
        emit(loadedState.copyWith(reviews: reviews, tabId: type));
        return;
      }
      if (type == DetailTab.cast.id) {
        final response = await _movieRepository.getMovieCredits(id);
        final casts = response.casts ?? List.empty();
        emit(loadedState.copyWith(casts: casts, tabId: type));
        return;
      }
      emit(loadedState.copyWith(tabId: type));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }
}
