import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';
import 'package:pixel_adventure/components/jump_button.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/components/level.dart';

class PixelAdventure extends FlameGame
    with
        HasKeyboardHandlerComponents,
        DragCallbacks,
        HasCollisionDetection,
        TapCallbacks {
  final VoidCallback onBackToMenu;

  PixelAdventure({required this.onBackToMenu});

  late CameraComponent cam;
  Player player = Player(character: 'Ninja Frog');
  late JoystickComponent joystick;
  bool showControls = true;
  bool playSounds = true;
  double soundVolume = 0.3;
  List<String> levelNames = [
    'Level-01',
    'Level-02',
    'Level-03',
    'Level-04',
    'Level-05'
  ];
  int currentLevelIndex = 0;

  int fruitsCollected = 0;
  final int fruitsRequired = 4;

  @override
  Future<void> onLoad() async {
    await images.loadAllImages();
    _loadLevel();

    if (showControls) {
      addJoystick();
      add(JumpButton());
    }

    addBackButton();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showControls) {
      updateJoystick();
    }
    super.update(dt);
  }

  void addJoystick() {
    joystick = JoystickComponent(
      priority: 10,
      knob: SpriteComponent(sprite: Sprite(images.fromCache('HUD/Knob.png'))),
      background:
          SpriteComponent(sprite: Sprite(images.fromCache('HUD/Joystick.png'))),
      margin: const EdgeInsets.only(left: 32, bottom: 32),
    );
    add(joystick);
  }

  void updateJoystick() {
    switch (joystick.direction) {
      case JoystickDirection.left:
      case JoystickDirection.upLeft:
      case JoystickDirection.downLeft:
        player.horizontalMovement = -1;
        break;
      case JoystickDirection.right:
      case JoystickDirection.upRight:
      case JoystickDirection.downRight:
        player.horizontalMovement = 1;
        break;
      default:
        player.horizontalMovement = 0;
        break;
    }
  }

  void loadNextLevel() {
    removeWhere((component) => component is Level);
    if (currentLevelIndex < levelNames.length - 1) {
      currentLevelIndex++;
      _loadLevel();
    } else {
      currentLevelIndex = 0;
      _loadLevel();
    }
  }

  void _loadLevel() {
    fruitsCollected = 0; // Reset the fruit counter for the new level
    Level world =
        Level(player: player, levelName: levelNames[currentLevelIndex]);
    cam = CameraComponent.withFixedResolution(
        world: world, width: 640, height: 360);
    cam.viewfinder.anchor = Anchor.topLeft;
    addAll([cam, world]);
  }

  void addBackButton() {
    add(SpriteButtonComponent(
      position:
          Vector2(60, 32), // Adjusted position to move the button to the right
      size: Vector2(50, 50),
      // button: Sprite(images.fromCache('HUD/BackButton.png')),
      // buttonDown: Sprite(images.fromCache('HUD/BackButtonPressed.png')),
      button: Sprite(images.fromCache('HUD/Knob.png')),
      buttonDown: Sprite(images.fromCache('HUD/Knob.png')),
      onPressed: onBackToMenu,
    ));
  }

  void onFruitCollected() {
    fruitsCollected++;
    if (fruitsCollected >= fruitsRequired) {
      loadNextLevel();
    }
  }
}
