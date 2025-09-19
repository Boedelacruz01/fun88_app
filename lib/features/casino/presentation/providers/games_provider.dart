// ignore_for_file: avoid_print

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/game.dart';
import '../../domain/usecases/get_games.dart';

class GamesProvider extends ChangeNotifier {
  final GetGames getGames;

  List<Game> _allGames = []; // store all fetched games
  List<Game> _filteredGames = [];
  final List<Game> _favorites = []; // store favorites
  bool loading = false;
  String _searchQuery = '';

  GamesProvider({required this.getGames}) {
    _loadFavorites(); // ✅ load saved favorites
    loadGames("Start");
  }

  List<Game> get games => _filteredGames;
  List<Game> get favorites => List.unmodifiable(_favorites);

  String get searchQuery => _searchQuery;

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favorites') ?? [];

    _favorites.clear();
    for (final id in favs) {
      try {
        final allCategories = [
          'Start',
          'New',
          'Slots',
          'Live',
          'Jackpots',
          'Table Game',
          'Bingo',
          'Others',
        ];

        for (final cat in allCategories) {
          final games = await getGames.call(cat);

          Game? g;
          try {
            g = games.firstWhere((x) => x.id == id);
          } catch (_) {
            g = null; // not found
          }

          if (g != null) {
            _favorites.add(g);
            break;
          }
        }
      } catch (_) {}
    }
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = _favorites.map((g) => g.id).toList();
    await prefs.setStringList('favorites', favs);
  }

  Future<void> loadGames(String category) async {
    loading = true;
    notifyListeners();

    if (category == "Favorites") {
      _allGames = _favorites;
      _applyFilter();
      loading = false;
      notifyListeners();
      return;
    }

    final result = await getGames.call(category);

    if (category == 'Start') {
      const int desired = 9;
      final Map<String, Game> uniqueById = {for (var g in result) g.id: g};

      if (uniqueById.length < desired) {
        final List<String> otherCats = [
          'New',
          'Slots',
          'Live',
          'Jackpots',
          'Table Game',
          'Bingo',
          'Others',
        ];

        for (final cat in otherCats) {
          if (uniqueById.length >= desired) break;
          try {
            final more = await getGames.call(cat);
            for (var g in more) {
              if (!uniqueById.containsKey(g.id)) {
                uniqueById[g.id] = g;
                if (uniqueById.length >= desired) break;
              }
            }
          } catch (_) {}
        }
      }

      final candidates = uniqueById.values.toList();
      candidates.shuffle(Random());
      _allGames = candidates.take(min(desired, candidates.length)).toList();
    } else {
      _allGames = result;
    }

    _applyFilter();
    loading = false;
    notifyListeners();
  }

  Future<void> prepareForSearch() async {
    loading = true;
    _searchQuery = '';
    notifyListeners();

    final List<String> searchCategories = [
      'Start',
      'New',
      'Slots',
      'Live',
      'Jackpots',
      'Table Game',
      'Bingo',
      'Others',
    ];

    final Map<String, Game> uniqueGames = {};

    for (final category in searchCategories) {
      try {
        final games = await getGames.call(category);
        for (var game in games) {
          uniqueGames[game.id] = game;
        }
      } catch (_) {
        continue;
      }
    }

    _allGames = uniqueGames.values.toList();
    _filteredGames = _allGames;
    loading = false;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilter();
    notifyListeners();
  }

  void clearSearch() {
    _searchQuery = '';
    _applyFilter();
    notifyListeners();
  }

  void toggleFavorite(Game game) {
    if (_favorites.any((g) => g.id == game.id)) {
      _favorites.removeWhere((g) => g.id == game.id);
    } else {
      _favorites.add(game);
    }
    _saveFavorites(); // ✅ persist favorites
    notifyListeners();
  }

  bool isFavorite(Game game) {
    return _favorites.any((g) => g.id == game.id);
  }

  void _applyFilter() {
    if (_searchQuery.isEmpty) {
      _filteredGames = _allGames;
    } else {
      final query = _searchQuery.toLowerCase();

      _filteredGames = _allGames.where((g) {
        final titleMatch = g.title.toLowerCase().contains(query);
        final fileName = g.imageAsset.split('/').last.toLowerCase();
        final fileMatch = fileName.contains(query);

        return titleMatch || fileMatch;
      }).toList();
    }
  }
}

// // ignore_for_file: avoid_print

// import 'dart:math';
// import 'package:flutter/material.dart';
// import '../../domain/entities/game.dart';
// import '../../domain/usecases/get_games.dart';

// class GamesProvider extends ChangeNotifier {
//   final GetGames getGames;

//   List<Game> _allGames = []; // store all fetched games
//   List<Game> _filteredGames = [];
//   final List<Game> _favorites = []; // store favorites
//   bool loading = false;
//   String _searchQuery = '';

//   GamesProvider({required this.getGames}) {
//     // Auto-load Start category when provider is created
//     loadGames("Start");
//   }

//   List<Game> get games => _filteredGames;
//   List<Game> get favorites => List.unmodifiable(_favorites);

//   Future<void> loadGames(String category) async {
//     loading = true;
//     notifyListeners();

//     if (category == "Favorites") {
//       // Show saved favorites
//       _allGames = _favorites;
//       _applyFilter();
//       loading = false;
//       notifyListeners();
//       return;
//     }

//     final result = await getGames.call(category);

//     if (category == 'Start') {
//       // Desired number of tiles on Start
//       const int desired = 9;

//       // Start with deduped results by id
//       final Map<String, Game> uniqueById = {for (var g in result) g.id: g};

//       // If not enough unique items, fetch from other common categories
//       if (uniqueById.length < desired) {
//         final List<String> otherCats = [
//           'New',
//           'Slots',
//           'Live',
//           'Jackpots',
//           'Table Game',
//           'Bingo',
//           'Others',
//         ];

//         for (final cat in otherCats) {
//           if (uniqueById.length >= desired) break;
//           try {
//             final more = await getGames.call(cat);
//             for (var g in more) {
//               if (!uniqueById.containsKey(g.id)) {
//                 uniqueById[g.id] = g;
//                 if (uniqueById.length >= desired) break;
//               }
//             }
//           } catch (_) {
//             // ignore single fetch failure and continue to next category
//           }
//         }
//       }

//       // Shuffle and pick up to `desired` items
//       final candidates = uniqueById.values.toList();
//       candidates.shuffle(Random());
//       _allGames = candidates.take(min(desired, candidates.length)).toList();
//     } else {
//       // Normal behavior for other categories
//       _allGames = result;
//     }

//     _applyFilter();
//     loading = false;
//     notifyListeners();
//   }

//   // NEW METHOD: Prepare comprehensive game list for search
//   Future<void> prepareForSearch() async {
//     loading = true;
//     _searchQuery = ''; // Clear any existing search
//     notifyListeners();

//     // Load games from multiple categories for comprehensive search
//     final List<String> searchCategories = [
//       'Start',
//       'New',
//       'Slots',
//       'Live',
//       'Jackpots',
//       'Table Game',
//       'Bingo',
//       'Others',
//     ];

//     final Map<String, Game> uniqueGames = {};

//     for (final category in searchCategories) {
//       try {
//         final games = await getGames.call(category);
//         print('Loaded ${games.length} games from $category');
//         for (var game in games) {
//           uniqueGames[game.id] = game; // Avoid duplicates using game ID
//         }
//       } catch (e) {
//         // Continue if one category fails
//         print('Failed to load games from $category: $e');
//         continue;
//       }
//     }

//     _allGames = uniqueGames.values.toList();
//     print('Total unique games loaded: ${_allGames.length}');

//     // Show all games initially (no filter)
//     _filteredGames = _allGames;
//     loading = false;
//     notifyListeners();

//     print(
//       'Search prepared with ${_filteredGames.length} games ready to display',
//     );
//   }

//   void setSearchQuery(String query) {
//     _searchQuery = query;
//     _applyFilter();
//     notifyListeners();
//   }

//   void toggleFavorite(Game game) {
//     if (_favorites.any((g) => g.id == game.id)) {
//       _favorites.removeWhere((g) => g.id == game.id);
//     } else {
//       _favorites.add(game);
//     }
//     notifyListeners();
//   }

//   bool isFavorite(Game game) {
//     return _favorites.any((g) => g.id == game.id);
//   }

//   void _applyFilter() {
//     if (_searchQuery.isEmpty) {
//       _filteredGames = _allGames;
//     } else {
//       final query = _searchQuery.toLowerCase();

//       _filteredGames = _allGames.where((g) {
//         final titleMatch = g.title.toLowerCase().contains(query);
//         final fileName = g.imageAsset.split('/').last.toLowerCase();
//         final fileMatch = fileName.contains(query);

//         return titleMatch || fileMatch;
//       }).toList();
//     }

//     // Debug logging
//     print('Search query: "$_searchQuery"');
//     print(
//       'Total games: ${_allGames.length}, Filtered: ${_filteredGames.length}',
//     );
//   }
// }
