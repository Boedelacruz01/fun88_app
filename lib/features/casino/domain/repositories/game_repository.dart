import '../entities/game.dart';

abstract class GameRepository {
  Future<List<Game>> getGames(String category);
}
