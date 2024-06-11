import 'package:flutter/material.dart';
import 'package:pixel_adventure/menu_screen.dart';
import 'package:pixel_adventure/game_screen.dart';

void main() {
  runApp(PixelAdventureApp());
}

class PixelAdventureApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pixel Adventure',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => MenuScreen(),
        '/game': (context) => GameScreen(),
      },
    );
  }
}
