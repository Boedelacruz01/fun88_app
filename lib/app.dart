import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/casino/presentation/pages/home_page.dart';
import 'features/casino/presentation/providers/category_provider.dart';
import 'features/casino/presentation/providers/games_provider.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Wrap with FutureBuilder to ensure Firebase is initialized
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        // Show loading while Firebase initializes
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        // Once Firebase is ready, return the app with providers
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => CategoryProvider()),
            ChangeNotifierProvider(
              create: (_) => GamesProvider(getGames: di.sl.get()),
            ),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fun88 Clone',
            theme: ThemeData(primarySwatch: Colors.blue),
            home: const HomePage(),
          ),
        );
      },
    );
  }
}
