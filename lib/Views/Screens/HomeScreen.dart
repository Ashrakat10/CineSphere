import 'package:flutter/material.dart';
import 'package:CineSphere/Model/Movie.dart';
import 'package:CineSphere/Provider/MovieProvider.dart';
import 'package:provider/provider.dart';
import 'package:CineSphere/Views/Screens/MovieDetailsScreen.dart';
import 'package:CineSphere/Views/Screens/SearchScreen.dart';
import 'package:CineSphere/Views/Screens/ProfileScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final provider = context.read<MovieProvider>();
      provider.fetchPopularMovies();
      provider.fetchTopRatedMovies();
      provider.fetchNowPlayingMovies();
      provider.fetchUpcomingMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          'CINESPHERE',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            icon: const Icon(Icons.person),
            color: Colors.white,
          ),
        ],
      ),

      body: Consumer<MovieProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.popularMovies.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.errorMessage.isNotEmpty &&
              provider.popularMovies.isEmpty) {
            return Center(
              child: Text(
                provider.errorMessage,
                style: const TextStyle(color: Colors.white),
              ),
            );
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (provider.popularMovies.isNotEmpty)
                  FeaturedMovie(movie: provider.popularMovies.first),
                const SizedBox(height: 20),
                MovieSection(
                  title: 'Popular Movies',
                  movies: provider.popularMovies,
                ),
                MovieSection(
                  title: 'Top Rated',
                  movies: provider.topRatedMovies,
                ),
                MovieSection(
                  title: 'Now Playing',
                  movies: provider.nowPlayingMovies,
                ),
                MovieSection(
                  title: 'Upcoming',
                  movies: provider.upcomingMovies,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class FeaturedMovie extends StatelessWidget {
  final Movie movie;
  const FeaturedMovie({super.key, required this.movie});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: NetworkImage(
            'https://image.tmdb.org/t/p/w780${movie.backdropPath}',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(16),
        alignment: Alignment.bottomLeft,
        color: Colors.black45,
        child: Text(
          movie.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class MovieSection extends StatelessWidget {
  final String title;
  final List<Movie> movies;

  const MovieSection({super.key, required this.title, required this.movies});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return MovieCard(movie: movies[index]);
            },
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MovieDetailsScreen(movie: movie),
            ),
          );
        },
        child: Container(
          width: 140,
          margin: const EdgeInsets.only(right: 12),
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
                ' ⭐${movie.voteAverage.toStringAsFixed(1)}',
                style: const TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
