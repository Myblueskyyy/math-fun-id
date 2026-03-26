import 'package:flame/components.dart';
import 'package:flame/collisions.dart';
import 'ground.dart';
import 'question_item.dart';
import '../platformer_game.dart';

enum PlayerState { idle, walk, jump }

class Player extends SpriteAnimationGroupComponent<PlayerState> with CollisionCallbacks, HasGameRef<PlatformerGame> {
  Vector2 velocity = Vector2.zero();
  final double gravity = 900;
  final double jumpSpeed = -400;
  final double moveSpeed = 200;
  
  bool isOnGround = false;
  int jumpsRemaining = 2; // double jump
  int moveDirection = 0; // -1 untuk kiri, 1 untuk kanan, 0 diam

  Player({required Vector2 position}) : super(position: position, size: Vector2(40, 40));

  @override
  Future<void> onLoad() async {
    // Membentuk animasi Idle
    final idleImg = await gameRef.images.load('char/Pink_Monster_Idle_4.png');
    final idleAnim = SpriteAnimation.fromFrameData(
      idleImg,
      SpriteAnimationData.sequenced(amount: 4, stepTime: 0.15, textureSize: Vector2(idleImg.width / 4, idleImg.height.toDouble())),
    );

    // Membentuk animasi Walk
    final walkImg = await gameRef.images.load('char/Pink_Monster_Walk_6.png');
    final walkAnim = SpriteAnimation.fromFrameData(
      walkImg,
      SpriteAnimationData.sequenced(amount: 6, stepTime: 0.1, textureSize: Vector2(walkImg.width / 6, walkImg.height.toDouble())),
    );

    // Membentuk animasi Jump
    final jumpImg = await gameRef.images.load('char/Pink_Monster_Jump_8.png');
    final jumpAnim = SpriteAnimation.fromFrameData(
      jumpImg,
      SpriteAnimationData.sequenced(amount: 8, stepTime: 0.1, textureSize: Vector2(jumpImg.width / 8, jumpImg.height.toDouble())),
    );

    animations = {
      PlayerState.idle: idleAnim,
      PlayerState.walk: walkAnim,
      PlayerState.jump: jumpAnim,
    };
    
    current = PlayerState.idle;
    
    add(RectangleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    
    velocity.x = moveDirection * moveSpeed;
    velocity.y += gravity * dt;
    
    position += velocity * dt;
    
    if (position.y > gameRef.size.y) {
      position.y = gameRef.size.y - size.y;
      velocity.y = 0;
      isOnGround = true;
      jumpsRemaining = 2;
    }

    if (position.x < 0) {
      position.x = 0;
    } else if (position.x > gameRef.size.x - size.x) {
      position.x = gameRef.size.x - size.x;
    }

    // Ubah status animasi
    if (!isOnGround || velocity.y != 0) {
      current = PlayerState.jump;
    } else if (velocity.x != 0) {
      current = PlayerState.walk;
    } else {
      current = PlayerState.idle;
    }

    // Membalik arah karakter jika menghadap ke kiri
    if (moveDirection < 0 && !isFlippedHorizontally) {
      flipHorizontallyAroundCenter();
    } else if (moveDirection > 0 && isFlippedHorizontally) {
      flipHorizontallyAroundCenter();
    }
  }

  void jump() {
    if (jumpsRemaining > 0) {
      velocity.y = jumpSpeed;
      jumpsRemaining--;
      isOnGround = false;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    
    if (other is Ground) {
      double playerCenterX = position.x + size.x / 2;
      double playerCenterY = position.y + size.y / 2;
      double groundCenterX = other.position.x + other.size.x / 2;
      double groundCenterY = other.position.y + other.size.y / 2;

      double dx = playerCenterX - groundCenterX;
      double dy = playerCenterY - groundCenterY;

      double width = (size.x + other.size.x) / 2;
      double height = (size.y + other.size.y) / 2;

      double crossWidth = width * dy;
      double crossHeight = height * dx;

      if (crossWidth > crossHeight) {
        if (crossWidth > -crossHeight) {
          if (velocity.y < 0) {
            position.y = other.position.y + other.size.y;
            velocity.y = 0; 
          }
        } else {
          if (velocity.x > 0) position.x = other.position.x - size.x;
        }
      } else {
        if (crossWidth > -crossHeight) {
          if (velocity.x < 0) position.x = other.position.x + other.size.x;
        } else {
          if (velocity.y > 0) {
            position.y = other.position.y - size.y;
            velocity.y = 0;
            isOnGround = true;
            jumpsRemaining = 2; 
          }
        }
      }
    } else if (other is QuestionItem) {
      other.removeFromParent();
      gameRef.triggerQuestion(other.itemIndex);
    }
  }

  @override
  void onCollisionEnd(PositionComponent other) {
    super.onCollisionEnd(other);
  }
}
