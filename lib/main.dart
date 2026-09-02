import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:CineSphere/firebase_options.dart';
import 'package:CineSphere/Provider/MovieProvider.dart';
import 'package:CineSphere/Provider/AuthProvider.dart';
import 'package:CineSphere/Views/Screens/SplashScreen.dart';
import 'package:CineSphere/Provider/FavoriteProvider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';
import 'package:CineSphere/Provider/WantToWatchProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  databaseFactory = databaseFactoryFfiWeb;

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteProvider()),
        ChangeNotifierProvider(create: (_) => WantToWatchProvider()),
      ],
      child: const CineSphereApp(),
    ),
  );
}

class CineSphereApp extends StatelessWidget {
  const CineSphereApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CINESPHERE',
      home: const SplashScreen(),
    );
  }
}
