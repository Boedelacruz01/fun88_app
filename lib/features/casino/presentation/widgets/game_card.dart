import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/game.dart';
import '../providers/games_provider.dart';

class GameCard extends StatefulWidget {
  final Game game;
  final VoidCallback onTap;
  const GameCard({super.key, required this.game, required this.onTap});

  @override
  State<GameCard> createState() => _GameCardState();
}

class _GameCardState extends State<GameCard> {
  @override
  Widget build(BuildContext context) {
    // ✅ Use select instead of watch to rebuild only when favorite status changes
    final isFavorite = context.select<GamesProvider, bool>(
      (provider) => provider.isFavorite(widget.game),
    );

    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(12), // smoother rounded corners
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12), // match rounding
        child: Stack(
          children: [
            // Full image with border
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: AspectRatio(
                aspectRatio: 1, // uniform square cards
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    widget.game.imageAsset,
                    fit: BoxFit.cover, // fills container without white spaces
                  ),
                ),
              ),
            ),

            // Favorite Star (top-right overlay)
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                onTap: () {
                  context.read<GamesProvider>().toggleFavorite(widget.game);
                },
                child: Icon(
                  isFavorite ? Icons.star : Icons.star_border,
                  color: isFavorite ? Colors.yellow : Colors.white,
                  size: 22,
                  shadows: [
                    Shadow(
                      blurRadius: 4,
                      color: Colors.black.withValues(alpha: 0.6),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../domain/entities/game.dart';
// import '../providers/games_provider.dart';

// class GameCard extends StatefulWidget {
//   final Game game;
//   final VoidCallback onTap;
//   const GameCard({super.key, required this.game, required this.onTap});

//   @override
//   State<GameCard> createState() => _GameCardState();
// }

// class _GameCardState extends State<GameCard> {
//   @override
//   Widget build(BuildContext context) {
//     final gamesProvider = context.watch<GamesProvider>();
//     final isFavorite = gamesProvider.isFavorite(widget.game);

//     return InkWell(
//       onTap: widget.onTap,
//       borderRadius: BorderRadius.circular(12), // smoother rounded corners
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(12), // match rounding
//         child: Stack(
//           children: [
//             // Full image with border
//             Container(
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey.shade300, width: 1),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: AspectRatio(
//                 aspectRatio: 1, // uniform square cards
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image.asset(
//                     widget.game.imageAsset,
//                     fit: BoxFit.cover, // fills container without white spaces
//                   ),
//                 ),
//               ),
//             ),

//             // Favorite Star (top-right overlay)
//             Positioned(
//               top: 6,
//               right: 6,
//               child: GestureDetector(
//                 onTap: () {
//                   gamesProvider.toggleFavorite(widget.game);
//                 },
//                 child: Icon(
//                   isFavorite ? Icons.star : Icons.star_border,
//                   color: isFavorite ? Colors.yellow : Colors.white,
//                   size: 22,
//                   shadows: [
//                     Shadow(
//                       blurRadius: 4,
//                       color: Colors.black.withValues(alpha: 0.6),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
