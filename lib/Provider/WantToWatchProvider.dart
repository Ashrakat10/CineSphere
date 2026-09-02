import 'package:flutter/material.dart';
import 'package:CineSphere/Model/Movie.dart';
import 'package:CineSphere/Service/DatabaseService.dart';

class WantToWatchProvider extends ChangeNotifier {

  final DatabaseService _databaseService = DatabaseService();
  List<Movie> _movies = [];
  bool _isLoading = false;

  List<Movie> get movies => _movies;
  bool get isLoading => _isLoading;

  Future<void> loadMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      _movies = await _databaseService.getWantToWatch();
    } catch (e) {
      _movies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addMovie(Movie movie) async {
    await _databaseService.addWantToWatch(movie);
    await loadMovies();
  }

  Future<void> removeMovie(int movieId) async {
    await _databaseService.removeWantToWatch(movieId);
    await loadMovies();
  }

  bool isMovieInList(int movieId) {
    return _movies.any(
      (movie) => movie.id == movieId,
    );
  }

  Future<void> toggleMovie(Movie movie) async {
    if (isMovieInList(movie.id)) {
      await removeMovie(movie.id);
    } else {
      await addMovie(movie);
    }
  }
}