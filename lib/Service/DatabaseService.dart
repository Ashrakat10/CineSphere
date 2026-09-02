import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:CineSphere/Model/Movie.dart';

class DatabaseService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'cinesphere.db',);
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterPath TEXT,
            overview TEXT,
            releaseDate TEXT,
            voteAverage REAL,
            runtime INTEGER
          )
        ''');

        await db.execute('''
          CREATE TABLE want_to_watch (
            id INTEGER PRIMARY KEY,
            title TEXT,
            posterPath TEXT,
            overview TEXT,
            releaseDate TEXT,
            voteAverage REAL,
            runtime INTEGER
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE want_to_watch (
              id INTEGER PRIMARY KEY,
              title TEXT,
              posterPath TEXT,
              overview TEXT,
              releaseDate TEXT,
              voteAverage REAL,
              runtime INTEGER
            )
          ''');
        }
      },
    );
  }

  Future<void> addFavorite(Movie movie) async {
    final db = await database;
    await db.insert('favorites', movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<void> removeFavorite(int movieId) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?',whereArgs: [movieId],);
  }

  Future<List<Movie>> getFavorites() async {
    final db = await database;
    final result = await db.query('favorites');
    return result.map((map) => Movie.fromMap(map)).toList();
  }

  Future<bool> isFavorite(int movieId) async {
    final db = await database;
    final result = await db.query('favorites', where: 'id = ?',whereArgs: [movieId],);
    return result.isNotEmpty;
  }


  Future<void> addWantToWatch(Movie movie) async {
    final db = await database;
    await db.insert('want_to_watch', movie.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
  }

  Future<void> removeWantToWatch(int movieId) async {
    final db = await database;
    await db.delete('want_to_watch', where: 'id = ?', whereArgs: [movieId],);
  }

  Future<List<Movie>> getWantToWatch() async {
    final db = await database;
    final result = await db.query('want_to_watch');
    return result.map((map) => Movie.fromMap(map)).toList();
  }

  Future<bool> isWantToWatch(int movieId) async {
    final db = await database;
    final result = await db.query('want_to_watch', where: 'id = ?', whereArgs: [movieId],);
    return result.isNotEmpty;
  }

  
}