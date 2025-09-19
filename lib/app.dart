import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'features/casino/presentation/pages/home_page.dart';
import 'features/casino/presentation/providers/category_provider.dart';
import 'features/casino/presentation/providers/games_provider.dart';
import 'injection_container.dart' as di;

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
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
  }
}
