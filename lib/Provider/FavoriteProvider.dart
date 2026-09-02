import 'package:flutter/material.dart';
import 'package:CineSphere/Model/Movie.dart';
import 'package:CineSphere/Service/DatabaseService.dart';

class FavoriteProvider extends ChangeNotifier {
  
  final DatabaseService _databaseService = DatabaseService();
  List<Movie> _favorites = [];
  bool _isLoading = false;

  List<Movie> get favorites => _favorites;
  bool get isLoading => _isLoading;

  Future<void> loadFavorites() async {
    _isLoading = true;
    notifyListeners();
    try {
      _favorites = await _databaseService.getFavorites();
    } catch (e) {
      _favorites = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addFavorite(Movie movie) async {
    await _databaseService.addFavorite(movie);
    await loadFavorites();
  }

  Future<void> removeFavorite(int movieId) async {
    await _databaseService.removeFavorite(movieId);
    await loadFavorites();
  }

  bool isFavorite(int movieId) {
    return _favorites.any( (movie) => movie.id == movieId,);
  }

  Future<void> toggleFavorite(Movie movie) async {
    if (isFavorite(movie.id)) {
      await removeFavorite(movie.id);
    } else {
      await addFavorite(movie);
    }
  }
}