import 'package:CineSphere/Model/Movie.dart';
import 'package:CineSphere/Service/TMDBService.dart';

class MovieController {
  final TMDBService _service = TMDBService();

  Future<List<Movie>> getPopularMovies() async {
    return await _service.getPopularMovies();
  }

  Future<List<Movie>> getTopRatedMovies() async {
    return await _service.getTopRatedMovies();
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    return await _service.getNowPlayingMovies();
  }

  Future<List<Movie>> getUpcomingMovies() async {
    return await _service.getUpcomingMovies();
  }

  Future<List<Movie>> searchMovies(String query) async {
    return await _service.searchMovies(query);
  }

  Future<Movie> getMovieDetails(int movieId) async {
    return await _service.getMovieDetails(movieId);
  }

}
