import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:CineSphere/Model/Movie.dart';
import 'package:CineSphere/Provider/WantToWatchProvider.dart';
import 'package:CineSphere/Views/Screens/MovieDetailsScreen.dart';

class WantToWatchScreen extends StatefulWidget {
  const WantToWatchScreen({super.key});
  @override
  State<WantToWatchScreen> createState() => _WantToWatchScreenState();
}

class _WantToWatchScreenState extends State<WantToWatchScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<WantToWatchProvider>().loadMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<WantToWatchProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text(
          'Want to Watch',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: provider.isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : provider.movies.isEmpty
              ? const Center(
                  child: Text(
                    'No movies in your list',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 18,
                    ),
                  ),
                )
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 16,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: provider.movies.length,
                  itemBuilder: (context, index) {
                    final Movie movie = provider.movies[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                MovieDetailsScreen(movie: movie),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            movie.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '⭐ ${movie.voteAverage.toStringAsFixed(1)}',
                            style: const TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}