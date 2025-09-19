import 'package:flutter/material.dart';

class GameDetailPage extends StatelessWidget {
  final String gameId;
  final String title;
  const GameDetailPage({super.key, required this.gameId, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.videogame_asset, size: 96),
            const SizedBox(height: 12),
            Text('Game ID: $gameId'),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () {
                // placeholder action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Play clicked (placeholder)')),
                );
              },
              child: const Text('Play (placeholder)'),
            ),
          ],
        ),
      ),
    );
  }
}
