import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/detail_bloc/detail_state.dart';
import 'package:moviehub/common/common.dart';

import '../../common/error_handler.dart';
import '../../common/type/detail_tab.dart';
import '../../data/model/movie.dart';
import '../../data/repository/repositories.dart';
import '../../di/locator.dart';

class DetailCubit extends Cubit<DetailState> {
  int currentPage = 0;
  final MovieRepository _movieRepository = locator<MovieRepository>();

  DetailCubit() : super(DetailInitializedState());

  Future<void> loadDataFirstTime(int id) async {
    emit(DetailLoadingState());

    try {
      final movie = await _movieRepository.getDetailMovie(id);
      emit(DetailLoadedState(movie, List.empty(), false));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }

  Future<void> loadReviewData(int id) async {
    final loadedState = cast<DetailLoadedState>(state);
    try {
      final reviews =
          (await _movieRepository.getMovieReviews(id, currentPage + 1))
                  .results ??
              List.empty();
      currentPage = currentPage + 1;
      emit(loadedState?.copyWith(reviews: reviews) ??
          DetailLoadedState(Movie(), reviews, false));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }

  Future<void> changeTab(int id, int type) async {
    final loadedState = cast<DetailLoadedState>(state);
    try {
      if(type == DetailTab.reviews.id ) {
        final reviews = (await _movieRepository.getMovieReviews(id, 1)).results ?? List.empty();
      }
      final MoviesResponse response = type == DetailTab.reviews.id
          ? (await _movieRepository.getMovieReviews(id, 1))
          : type == DetailTab.cast.id
          ? (await _movieRepository.getMovieCredits(id))
          : MoviesResponse();

      final newState = state;
      currentPage = response.page;
      if (newState is HomeLoadSuccess) {
        emit(newState.copyWith(tabMovies: response.results));
      }
    } catch (exception) {
      final response = handelError(exception);
      emit(HomeLoadFailure(response));
    }
  }
}
