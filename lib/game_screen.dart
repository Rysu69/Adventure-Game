import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameWidget(
            game: PixelAdventure(onBackToMenu: () {
              Navigator.pop(context);
            }),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Back to Menu'),
            ),
          ),
        ],
      ),
    );
  }
}
