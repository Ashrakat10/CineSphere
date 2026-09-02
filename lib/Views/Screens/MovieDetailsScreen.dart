import 'package:flutter/material.dart';
import 'package:CineSphere/Model/Movie.dart';
import 'package:CineSphere/Provider/MovieProvider.dart';
import 'package:provider/provider.dart';
import 'package:CineSphere/Provider/FavoriteProvider.dart';
import 'package:CineSphere/Provider/WantToWatchProvider.dart';

class MovieDetailsScreen extends StatefulWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieProvider>().fetchMovieDetails(widget.movie.id);
      context.read<FavoriteProvider>().loadFavorites();
      context.read<WantToWatchProvider>().loadMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MovieProvider>();
    final favoriteProvider = context.watch<FavoriteProvider>();
    final wantToWatchProvider = context.watch<WantToWatchProvider>();

    if (provider.isDetailsLoading) {
      return const Scaffold(
        backgroundColor: Colors.black,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final movie = provider.selectedMovie ?? widget.movie;
    final isFavorite = favoriteProvider.isFavorite(movie.id);
    final isWantToWatch = wantToWatchProvider.isMovieInList(movie.id);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'MOVIE Details',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                    child:Text(
                        movie.title,
                        style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await context.read<FavoriteProvider>()
                          .toggleFavorite(movie);
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: isFavorite ? Colors.pink : Colors.white, size: 30,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await context.read<WantToWatchProvider>().toggleMovie(movie);
                        },
                        icon: Icon(
                          isWantToWatch ? Icons.bookmark : Icons.bookmark_border,
                          color: isWantToWatch ? Colors.green : Colors.white, size: 30,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '⭐ ${movie.voteAverage.toStringAsFixed(1)}',
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Release Date: ${movie.releaseDate}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Runtime: ${movie.runtime} minutes',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  const SizedBox(height: 15),
                  Text(
                    movie.genres.join(' • '),
                    style: const TextStyle(color: Colors.white70, fontSize: 15),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Overview',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.overview,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 15,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
