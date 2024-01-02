import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class JumpButton extends SpriteComponent
    with HasGameRef<PixelAdventure>, TapCallbacks {
  JumpButton();

  final margin = 32; // Margin sekitar tombol
  final buttonSize = 90; // Ukuran tombol

  @override
  FutureOr<void> onLoad() {
    // Menerapkan sprite
    sprite = Sprite(game.images.fromCache('HUD/JumpButton.png'));

    // Menerapkan posisi tombol
    position = Vector2(
      game.size.x - margin - buttonSize,
      game.size.y - margin - buttonSize,
    );
    priority = 10; // Atur prioritas tombol
    return super.onLoad();
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Set player lompat
    game.player.hasJumped = true;
    super.onTapDown(event);
  }

  @override
  void onTapUp(TapUpEvent event) {
    // Unset player lompat
    game.player.hasJumped = false;
    super.onTapUp(event);
  }
}
