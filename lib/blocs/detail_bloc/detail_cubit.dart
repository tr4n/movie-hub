import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/detail_bloc/detail_state.dart';
import 'package:moviehub/common/common.dart';
import 'package:moviehub/data/repository/favorite_repository.dart';

import '../../common/error_handler.dart';
import '../../common/type/detail_tab.dart';
import '../../data/repository/repositories.dart';
import '../../di/locator.dart';

class DetailCubit extends Cubit<DetailState> {
  int _currentPage = 0;
  int _totalPage = 0;
  final MovieRepository _movieRepository = locator<MovieRepository>();
  final FavoriteRepository _favoriteRepository =
      locator.get<FavoriteRepository>();

  DetailCubit() : super(DetailInitializedState());

  Future<void> loadDataFirstTime(int id) async {
    emit(DetailLoadingState());

    try {
      final movie = await _movieRepository.getDetailMovie(id);
      final isFavorite = (await _favoriteRepository.getFavorite(id))?.id == id;
      emit(DetailLoadedState(movie: movie, isFavorite: isFavorite));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }

  Future<void> loadMoreData(int movieId, int tabId) async {
    if (tabId == DetailTab.reviews.id) {
      return _loadReviewData(movieId);
    }
    if (tabId == DetailTab.similar.id) {
      return _loadSimilarMoviesData(movieId);
    }
    return loadDataFirstTime(movieId);
  }

  Future<void> _loadSimilarMoviesData(int id) async {
    final loadedState = cast<DetailLoadedState>(state);
    if (loadedState == null || _currentPage >= _totalPage) {
      return;
    }
    emit(loadedState.copyWith(loading: true));
    try {
      final response =
          await _movieRepository.getSimilarMovies(id, _currentPage + 1);
      final similarMovies = response.results;
      if (similarMovies.isNotEmpty) {
        _currentPage = _currentPage + 1;
      }

      emit(loadedState.copyWith(
          similars: loadedState.similars + similarMovies, loading: false));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }

  Future<void> _loadReviewData(int id) async {
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
      if (type == DetailTab.similar.id) {
        final response = await _movieRepository.getSimilarMovies(id, 1);
        final movies = response.results;
        _currentPage = response.page;
        _totalPage = response.totalPages;
        emit(loadedState.copyWith(similars: movies, tabId: type));
        return;
      }
      emit(loadedState.copyWith(tabId: type));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }

  Future<void> markFavoriteOrNot() async {
    final loadedState = cast<DetailLoadedState>(state);
    if (loadedState == null) return;
    try {
      if (loadedState.isFavorite) {
        await _favoriteRepository.removeFavorite(loadedState.movie.id);
      } else {
        await _favoriteRepository.addFavorite(loadedState.movie.toFavorite());
      }
      emit(loadedState.copyWith(favorite: !loadedState.isFavorite));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }
}
