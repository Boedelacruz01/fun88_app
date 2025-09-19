import 'dart:async';
import '../../domain/entities/game.dart';
import '../../domain/repositories/game_repository.dart';
import '../models/game_model.dart';

class GameRepositoryImpl implements GameRepository {
  // Centralized mapping of filenames to game titles
  final Map<String, String> _titleMap = {
    'aztec-bonus-lines.webp': 'Aztec Bonus Lines',
    'pride-of-persia.webp': 'Pride of Persia',
    'beach-life.webp': 'Beach Life',
    'big-bad-wolf.webp': 'Big Bad Wolf',
    'book-of-egypt.webp': 'Book of Egypt',
    'crocodile-blitz-xtreme-fb.webp': 'Crocodile Blitz Xtreme FB',
    'inca-jackpot.webp': 'Inca Jackpot',
    'pirates-power.webp': 'Pirates Power',
  };

  // In-memory placeholder data with multiple images per category
  final Map<String, List<GameModel>> _store = {};

  GameRepositoryImpl() {
    _store.addAll({
      'Start': List.generate(8, (i) {
        final image = [
          'assets/images/aztec-bonus-lines.webp',
          'assets/images/pride-of-persia.webp',
          'assets/images/beach-life.webp',
          'assets/images/big-bad-wolf.webp',
          'assets/images/book-of-egypt.webp',
          'assets/images/crocodile-blitz-xtreme-fb.webp',
          'assets/images/inca-jackpot.webp',
          'assets/images/pirates-power.webp',
        ][i % 8];
        return GameModel(
          id: 's$i',
          title: _titleFromImage(image),
          imageAsset: image,
        );
      }),
      'New': List.generate(8, (i) {
        final image = [
          'assets/images/pride-of-persia.webp',
          'assets/images/aztec-bonus-lines.webp',
          'assets/images/pirates-power.webp',
          'assets/images/big-bad-wolf.webp',
          'assets/images/book-of-egypt.webp',
          'assets/images/beach-life.webp',
          'assets/images/inca-jackpot.webp',
          'assets/images/crocodile-blitz-xtreme-fb.webp',
        ][i % 8];
        return GameModel(
          id: 'n$i',
          title: _titleFromImage(image),
          imageAsset: image,
        );
      }),
      'Slots': List.generate(8, (i) {
        final image = [
          'assets/images/beach-life.webp',
          'assets/images/pride-of-persia.webp',
          'assets/images/aztec-bonus-lines.webp',
          'assets/images/book-of-egypt.webp',
          'assets/images/big-bad-wolf.webp',
          'assets/images/inca-jackpot.webp',
          'assets/images/pirates-power.webp',
          'assets/images/crocodile-blitz-xtreme-fb.webp',
        ][i % 8];
        return GameModel(
          id: 'sl$i',
          title: _titleFromImage(image),
          imageAsset: image,
        );
      }),
      'Live': List.generate(8, (i) {
        final image = [
          'assets/images/big-bad-wolf.webp',
          'assets/images/aztec-bonus-lines.webp',
          'assets/images/pride-of-persia.webp',
          'assets/images/book-of-egypt.webp',
          'assets/images/beach-life.webp',
          'assets/images/pirates-power.webp',
          'assets/images/inca-jackpot.webp',
          'assets/images/crocodile-blitz-xtreme-fb.webp',
        ][i % 8];
        return GameModel(
          id: 'l$i',
          title: _titleFromImage(image),
          imageAsset: image,
        );
      }),
      'Jackpots': List.generate(8, (i) {
        final image = [
          'assets/images/book-of-egypt.webp',
          'assets/images/beach-life.webp',
          'assets/images/pride-of-persia.webp',
          'assets/images/big-bad-wolf.webp',
          'assets/images/aztec-bonus-lines.webp',
          'assets/images/inca-jackpot.webp',
          'assets/images/crocodile-blitz-xtreme-fb.webp',
          'assets/images/pirates-power.webp',
        ][i % 8];
        return GameModel(
          id: 'j$i',
          title: _titleFromImage(image),
          imageAsset: image,
        );
      }),
      'Table Game': List.generate(8, (i) {
        final image = [
          'assets/images/crocodile-blitz-xtreme-fb.webp',
          'assets/images/book-of-egypt.webp',
          'assets/images/beach-life.webp',
          'assets/images/aztec-bonus-lines.webp',
          'assets/images/pride-of-persia.webp',
          'assets/images/pirates-power.webp',
          'assets/images/big-bad-wolf.webp',
          'assets/images/inca-jackpot.webp',
        ][i % 8];
        return GameModel(
          id: 't$i',
          title: _titleFromImage(image),
          imageAsset: image,
        );
      }),
      'Bingo': List.generate(8, (i) {
        final image = [
          'assets/images/inca-jackpot.webp',
          'assets/images/beach-life.webp',
          'assets/images/book-of-egypt.webp',
          'assets/images/pride-of-persia.webp',
          'assets/images/aztec-bonus-lines.webp',
          'assets/images/pirates-power.webp',
          'assets/images/crocodile-blitz-xtreme-fb.webp',
          'assets/images/big-bad-wolf.webp',
        ][i % 8];
        return GameModel(
          id: 'b$i',
          title: _titleFromImage(image),
          imageAsset: image,
        );
      }),
      'Others': List.generate(8, (i) {
        final image = [
          'assets/images/pirates-power.webp',
          'assets/images/pride-of-persia.webp',
          'assets/images/aztec-bonus-lines.webp',
          'assets/images/beach-life.webp',
          'assets/images/book-of-egypt.webp',
          'assets/images/big-bad-wolf.webp',
          'assets/images/inca-jackpot.webp',
          'assets/images/crocodile-blitz-xtreme-fb.webp',
        ][i % 8];
        return GameModel(
          id: 'o$i',
          title: _titleFromImage(image),
          imageAsset: image,
        );
      }),
      'Search': [],
    });
  }

  String _titleFromImage(String assetPath) {
    final fileName = assetPath.split('/').last;
    return _titleMap[fileName] ?? fileName; // <-- use central _titleMap
  }

  @override
  Future<List<Game>> getGames(String category) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _store[category] ?? _store['Start']!;
  }
}
