import 'package:get_it/get_it.dart';
import 'features/casino/data/repositories/game_repository_impl.dart';
import 'features/casino/domain/repositories/game_repository.dart';
import 'features/casino/domain/usecases/get_games.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Usecases
  sl.registerLazySingleton(() => GetGames(sl()));

  // Repositories (in-memory / local for demo)
  sl.registerLazySingleton<GameRepository>(() => GameRepositoryImpl());
}
