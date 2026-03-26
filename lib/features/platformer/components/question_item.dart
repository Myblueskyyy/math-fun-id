import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import '../platformer_game.dart';

class QuestionItem extends SpriteComponent with HasGameRef<PlatformerGame> {
  final int itemIndex;
  
  QuestionItem({required this.itemIndex, required Vector2 position})
      : super(position: position, size: Vector2(30, 30));

  @override
  Future<void> onLoad() async {
    add(RectangleHitbox());
    sprite = await gameRef.loadSprite('star.png');
    anchor = Anchor.center;
    // Mengamankan posisi center anchoring (memindahkan offset agar terlihat alami seperti semula)
    position += Vector2(15, 15); 
  }

  @override
  void update(double dt) {
    super.update(dt);
    angle += 2 * dt; // Rotasi perlahan-lahan
  }
}
