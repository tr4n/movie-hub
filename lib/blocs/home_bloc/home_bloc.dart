import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/base/base.dart';
import 'package:moviehub/blocs/home_bloc/home_event.dart';
import 'package:moviehub/common/common.dart';
import 'package:moviehub/data/repository/repositories.dart';
import 'package:moviehub/di/locator.dart';

import '../../data/model/movie.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  final MovieRepository movieRepository;

  HomeBloc({MovieRepository? movieRepository})
      : movieRepository = movieRepository ?? locator<MovieRepository>(),
        super(HomeInitializedState()) {
    on<HomeGetDataEvent>((event, emit) => _onLoadData(event, emit));
  }

  void _onLoadData(HomeGetDataEvent event, Emitter<HomeState> emit) async {
    emit(HomeLoadingState());

    try {
      final List<Movie> trendingMovies =
          (await movieRepository.getTrending()).results;
      final List<Movie> tabMovies = event.type == HomeTab.nowPlaying.id
          ? (await movieRepository.getNowPlaying()).results
          : event.type == HomeTab.upcoming.id
              ? (await movieRepository.getUpcoming()).results
              : event.type == HomeTab.topRated.id
                  ? (await movieRepository.getTopRated()).results
                  : event.type == HomeTab.popular.id
                      ? (await movieRepository.getPopular()).results
                      : List.empty();

      emit(HomeLoadSuccess(trendingMovies, tabMovies));
    } catch (exception) {
      final response = handelError(exception);
      emit(HomeLoadFailure(response));
    }
  }
}
