import 'package:flutter/material.dart';
import 'package:CineSphere/Model/Movie.dart';
import 'package:CineSphere/Controller/MovieController.dart';

class MovieProvider extends ChangeNotifier {
  final MovieController _controller = MovieController();
  List<Movie> _popularMovies = [];
  List<Movie> _topRatedMovies = [];
  List<Movie> _nowPlayingMovies = [];
  List<Movie> _upcomingMovies = [];
  List<Movie> _searchResults = [];
  Movie? _selectedMovie;
  bool _isDetailsLoading = false;
  bool _isLoading = false;
  int _loadingCount = 0;
  String _errorMessage = '';

  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get topRatedMovies => _topRatedMovies;
  List<Movie> get nowPlayingMovies => _nowPlayingMovies;
  List<Movie> get upcomingMovies => _upcomingMovies;
  List<Movie> get searchResults => _searchResults;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;
  Movie? get selectedMovie => _selectedMovie;
  bool get isDetailsLoading => _isDetailsLoading;

  void _startLoading() {
    _loadingCount++;
    _isLoading = true;
    notifyListeners();
  }

  void _stopLoading() {
    _loadingCount--;

    if (_loadingCount <= 0) {
      _loadingCount = 0;
      _isLoading = false;
    }

    notifyListeners();
  }

  Future<void> fetchPopularMovies() async {
    _startLoading();

    try {
      _popularMovies = await _controller.getPopularMovies();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _stopLoading();
    }
  }

  Future<void> fetchTopRatedMovies() async {
    _startLoading();

    try {
      _topRatedMovies = await _controller.getTopRatedMovies();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _stopLoading();
    }
  }

  Future<void> fetchNowPlayingMovies() async {
    _startLoading();

    try {
      _nowPlayingMovies = await _controller.getNowPlayingMovies();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _stopLoading();
    }
  }

  Future<void> fetchUpcomingMovies() async {
    _startLoading();

    try {
      _upcomingMovies = await _controller.getUpcomingMovies();
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _stopLoading();
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.trim().isEmpty) {
      _searchResults = [];
      notifyListeners();
      return;
    }

    _startLoading();

    try {
      _searchResults = await _controller.searchMovies(query);
      _errorMessage = '';
    } catch (e) {
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _stopLoading();
    }
  }

  Future<void> fetchMovieDetails(int movieId) async {
    _isDetailsLoading = true;
    notifyListeners();

    try {
      _selectedMovie = await _controller.getMovieDetails(movieId);
      _errorMessage = '';
    } catch (e) {
      _selectedMovie = null;
      _errorMessage = e.toString().replaceFirst('Exception: ', '');
    } finally {
      _isDetailsLoading = false;
      notifyListeners();
    }
  }
}
