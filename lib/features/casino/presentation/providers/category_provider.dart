import 'package:flutter/material.dart';

class CategoryProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> categories = [
    {'label': 'Search', 'icon': Icons.search, 'flex': 1},
    {'label': 'Start', 'icon': Icons.local_fire_department, 'flex': 1},
    {'label': 'New', 'icon': Icons.fiber_new, 'flex': 1},
    {'label': 'Slots', 'icon': Icons.casino, 'flex': 1},
    {'label': 'Live', 'icon': Icons.live_tv, 'flex': 1},
    {'label': 'Jackpots', 'icon': Icons.card_giftcard, 'flex': 2}, // wider text
    {'label': 'Table Game', 'icon': Icons.table_bar, 'flex': 2}, // wider text
    {'label': 'Bingo', 'icon': Icons.sports_esports, 'flex': 1},
    {'label': 'Others', 'icon': Icons.category, 'flex': 1},
  ];

  String _selected = 'Start';
  bool _searchMode = false;

  String get selected => _selected;
  bool get searchMode => _searchMode;

  void select(String cat) {
    if (cat == 'Search') {
      // Toggle search mode instead of forcing it
      _searchMode = !_searchMode;
      _selected = 'Search';
    } else {
      _selected = cat;
      _searchMode = false;
    }
    notifyListeners();
  }
}

// import 'package:flutter/material.dart';

// class CategoryProvider extends ChangeNotifier {
//   final List<Map<String, dynamic>> categories = [
//     {'label': 'Search', 'icon': Icons.search},
//     {'label': 'Start', 'icon': Icons.local_fire_department},
//     {'label': 'New', 'icon': Icons.fiber_new},
//     {'label': 'Slots', 'icon': Icons.casino},
//     {'label': 'Live', 'icon': Icons.live_tv},
//     {'label': 'Jackpots', 'icon': Icons.card_giftcard},
//     {'label': 'Table Game', 'icon': Icons.table_bar},
//     {'label': 'Bingo', 'icon': Icons.sports_esports},
//     {'label': 'Others', 'icon': Icons.category},
//   ];

//   String _selected = 'Start';
//   bool _searchMode = false;

//   String get selected => _selected;
//   bool get searchMode => _searchMode;

//   void select(String cat) {
//     if (cat == 'Search') {
//       // Toggle search mode instead of forcing it
//       _searchMode = !_searchMode;
//       _selected = 'Search';
//     } else {
//       _selected = cat;
//       _searchMode = false;
//     }

//     notifyListeners();
//   }
// }
