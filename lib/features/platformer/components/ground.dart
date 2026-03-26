import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../platformer_game.dart';

class Ground extends SpriteComponent with HasGameRef<PlatformerGame> {
  Ground({required Vector2 position, required Vector2 size})
      : super(position: position, size: size);

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    sprite = await gameRef.loadSprite('tiles/Tile_02.png');
  }
}
