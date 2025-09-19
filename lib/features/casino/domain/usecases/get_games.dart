import '../../domain/entities/game.dart';
import '../../domain/repositories/game_repository.dart';

class GetGames {
  final GameRepository repository;
  GetGames(this.repository);

  Future<List<Game>> call(String category) async {
    return await repository.getGames(category);
  }
}
