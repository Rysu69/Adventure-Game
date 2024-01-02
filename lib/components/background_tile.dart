import 'dart:async';

import 'package:flame/components.dart';
import 'package:flame/parallax.dart';
import 'package:flutter/material.dart';

class BackgroundTile extends ParallaxComponent {
 final String color;

 // Membuat BackgroundTile dengan warna yang diberikan
 BackgroundTile({
    this.color = 'Gray',
    position,
 }) : super(
          position: position,
        );

 // Kecepatan dengan mana latar belakang ini bergerak
 final double scrollSpeed = 40;

 @override
 FutureOr<void> onLoad() async {
    // Setelah urutan komponen untuk dirender
    priority = -10;

    // Setelah ukuran komponen
    size = Vector2.all(64);

    // Muat paralaks dengan gambar yang diberikan
    parallax = await gameRef.loadParallax(
      [ParallaxImageData('Background/$color.png')],
      baseVelocity: Vector2(0, -scrollSpeed),
      repeat: ImageRepeat.repeat,
      fill: LayerFill.none,
    );

    // Panggil metode onLoad dari kelas superclass
    return super.onLoad();
 }
}