import 'dart:async';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:pixel_adventure/components/player.dart';
import 'package:pixel_adventure/pixel_adventure.dart';

class Checkpoint extends SpriteAnimationComponent
    with HasGameRef<PixelAdventure>, CollisionCallbacks {

 static int requiredFruits = 4;

  Checkpoint({
    position,
    size,
  }) : super(
          position: position,
          size: size,
        );

  @override
  FutureOr<void> onLoad() {
    // debugMode = true;
    //mengatur hitbox checkpoint
    add(RectangleHitbox(
      position: Vector2(18, 56),
      size: Vector2(12, 8),
      collisionType: CollisionType.passive,
    ));

    animation = SpriteAnimation.fromFrameData(
      game.images
          .fromCache('Items/Checkpoints/Checkpoint/Checkpoint (No Flag).png'),
      SpriteAnimationData.sequenced(
        amount: 1,
        stepTime: 1,
        textureSize: Vector2.all(64),
      ),
    );
    return super.onLoad();
  }

//logic ketika player bersentuhan dengan checkpoint
  @override 
  void onCollisionStart(
      Set<Vector2> intersectionPoints, PositionComponent other) {
    if (other is Player && collectedFruits >= requiredFruits) {
      _reachedCheckpoint();
    }
    super.onCollisionStart(intersectionPoints, other);
  }

 //animasi ketika menyentuh checkpoint
  void _reachedCheckpoint() async {
  
      animation = SpriteAnimation.fromFrameData(
        game.images.fromCache(
            'Items/Checkpoints/Checkpoint/Checkpoint (Flag Out) (64x64).png'),
        SpriteAnimationData.sequenced(
          amount: 26,
          stepTime: 0.05,
          textureSize: Vector2.all(64),
          loop: false,
        ),
      );
    
    await animationTicker?.completed;

    animation = SpriteAnimation.fromFrameData(
      game.images.fromCache(
          'Items/Checkpoints/Checkpoint/Checkpoint (Flag Idle)(64x64).png'),
      SpriteAnimationData.sequenced(
        amount: 10,
        stepTime: 0.05,
        textureSize: Vector2.all(64),
      ),
    );
  }
}
