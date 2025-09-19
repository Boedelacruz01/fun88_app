class Game {
  final String id;
  final String title;
  final String imageAsset; // local placeholder path
  final bool isFavorite;

  Game({
    required this.id,
    required this.title,
    required this.imageAsset,
    this.isFavorite = false,
  });
}
