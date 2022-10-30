import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/home_bloc/home_state.dart';
import 'package:moviehub/common/common.dart';
import 'package:moviehub/data/platform/network/response/movies_response.dart';

import '../../common/error_handler.dart';
import '../../data/model/movie.dart';
import '../../data/repository/repositories.dart';
import '../../di/locator.dart';

class HomeCubit extends Cubit<HomeState> {
  int currentPage = 0;
  final MovieRepository _movieRepository = locator<MovieRepository>();

  HomeCubit() : super(HomeInitializedState());

  Future<void> loadDataFirstTime(int type) async {
    emit(HomeLoadingState());

    try {
      final List<Movie> trendingMovies =
          (await _movieRepository.getTrending()).results;

      final MoviesResponse response = type == HomeTab.nowPlaying.id
          ? (await _movieRepository.getNowPlaying())
          : type == HomeTab.upcoming.id
              ? (await _movieRepository.getUpcoming())
              : type == HomeTab.topRated.id
                  ? (await _movieRepository.getTopRated())
                  : type == HomeTab.popular.id
                      ? (await _movieRepository.getPopular())
                      : MoviesResponse();
      currentPage = response.page;
      final List<Movie> tabMovies = response.results;

      emit(HomeLoadSuccess(trendingMovies, tabMovies, false));
    } catch (exception) {
      final response = handelError(exception);
      emit(HomeLoadFailure(response));
    }
  }

  Future<void> changeTab(int type) async {
    try {
      final MoviesResponse response = type == HomeTab.nowPlaying.id
          ? (await _movieRepository.getNowPlaying())
          : type == HomeTab.upcoming.id
              ? (await _movieRepository.getUpcoming())
              : type == HomeTab.topRated.id
                  ? (await _movieRepository.getTopRated())
                  : type == HomeTab.popular.id
                      ? (await _movieRepository.getPopular())
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

  Future<void> loadMore(int type) async {
    final newState = cast<HomeLoadSuccess>(state);
    if (newState == null) {
      return;
    }
    emit(newState.copyWith(loading: true));
    try {
      final MoviesResponse response = type == HomeTab.nowPlaying.id
          ? (await _movieRepository.getNowPlaying(currentPage + 1))
          : type == HomeTab.upcoming.id
              ? (await _movieRepository.getUpcoming(currentPage + 1))
              : type == HomeTab.topRated.id
                  ? (await _movieRepository.getTopRated(currentPage + 1))
                  : type == HomeTab.popular.id
                      ? (await _movieRepository.getPopular(currentPage + 1))
                      : MoviesResponse();

      if (response.results.isNotEmpty) {
        currentPage = response.page;
        final List<Movie> tabMovies = response.results;

        emit(newState.copyWith(
          tabMovies: newState.tabMovies + tabMovies,
          loading: false,
        ));
      }
    } catch (exception) {
      final response = handelError(exception);
      emit(HomeLoadFailure(response));
    }
  }
}
