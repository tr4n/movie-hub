import 'package:moviehub/data/model/movie.dart';

import '../platform/network/api/api.dart';
import '../platform/network/response/responses.dart';

class MovieRepository {
  final MovieApi api;

  MovieRepository(this.api);

  Future<MoviesResponse> getLatest([int page = 1]) async {
    return api.getLatestMovies(page);
  }

  Future<MoviesResponse> getNowPlaying([int page = 1]) async {
    return api.getNowPlayingMovies(page);
  }

  Future<MoviesResponse> getPopular([int page = 1]) async {
    return api.getPopularMovies(page);
  }

  Future<MoviesResponse> getTopRated([int page = 1]) async {
    return api.getTopRatedMovies(page);
  }

  Future<MoviesResponse> getUpcoming([int page = 1]) async {
    return api.getUpcomingMovies(page);
  }

  Future<Movie> getDetailMovie(int id) async {
    return api.getDetailMovie(id);
  }

  Future<MoviesResponse> getTrending() async {
    return api.getTrendingMovies();
  }
}
