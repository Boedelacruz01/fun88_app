import '../../domain/entities/game.dart';

class GameModel extends Game {
  GameModel({
    required super.id,
    required super.title,
    required super.imageAsset,
    super.isFavorite,
  });

  factory GameModel.fromJson(Map<String, dynamic> json) {
    return GameModel(
      id: json['id'],
      title: json['title'],
      imageAsset: json['imageAsset'],
      isFavorite: json['isFavorite'] ?? false,
    );
  }
}
