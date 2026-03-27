import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../platformer_game.dart';

class Ground extends PositionComponent with HasGameRef<PlatformerGame> {
  Ground({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    
    final sprite = await gameRef.loadSprite('tiles/Tile_02.png');
    
    // Gunakan tinggi platform sebagai ukuran tile agar tetap 1:1
    final tileSize = size.y;
    
    // Hitung berapa banyak tile yang dibutuhkan untuk menutupi lebar platform
    int tilesToDraw = (size.x / tileSize).ceil();
    
    for (int i = 0; i < tilesToDraw; i++) {
      add(SpriteComponent(
        sprite: sprite,
        position: Vector2(i * tileSize, 0),
        size: Vector2(tileSize, tileSize),
      ));
    }
  }
}
