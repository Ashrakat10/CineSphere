import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:CineSphere/Utils/api_constants.dart';
import 'package:CineSphere/Model/Movie.dart';

class TMDBService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> _getMovies(String endpoint) async {
    final uri = Uri.parse('$_baseUrl$endpoint?api_key=${ApiConstants.apiKey}');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'] ?? [];
        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } on http.ClientException {
      throw Exception('No internet connection');
    }
  }

  Future<List<Movie>> getPopularMovies() async {
    return _getMovies('/movie/popular');
  }

  Future<List<Movie>> getTopRatedMovies() async {
    return _getMovies('/movie/top_rated');
  }

  Future<List<Movie>> getNowPlayingMovies() async {
    return _getMovies('/movie/now_playing');
  }

  Future<List<Movie>> getUpcomingMovies() async {
    return _getMovies('/movie/upcoming');
  }

  Future<List<Movie>> searchMovies(String query) async {
    final uri = Uri.parse(
      '$_baseUrl/search/movie'
      '?api_key=${ApiConstants.apiKey}'
      '&query=${Uri.encodeComponent(query)}',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final List results = data['results'] ?? [];

        return results.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception('Failed to search movies');
      }
    } on http.ClientException {
      throw Exception('No internet connection');
    }
  }

  Future<Movie> getMovieDetails(int movieId) async {
    final uri = Uri.parse(
      '$_baseUrl/movie/$movieId?api_key=${ApiConstants.apiKey}',
    );

    try {
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } on http.ClientException {
      throw Exception('No internet connection');
    }
  }
}
