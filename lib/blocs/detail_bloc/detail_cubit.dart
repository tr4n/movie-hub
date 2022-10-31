import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moviehub/blocs/detail_bloc/detail_state.dart';

import '../../common/error_handler.dart';
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

      emit(DetailLoadedState(movie, false));
    } catch (exception) {
      final response = handelError(exception);
      emit(DetailLoadFailure(response));
    }
  }
}
