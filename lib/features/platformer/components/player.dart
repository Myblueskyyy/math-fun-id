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
    final idleSprites = <Sprite>[];
    for (int i = 1; i <= 4; i++) {
      idleSprites.add(await gameRef.loadSprite('char/Idle/$i.png'));
    }
    final idleAnim = SpriteAnimation.spriteList(
      idleSprites,
      stepTime: 0.15,
    );

    // Membentuk animasi Walk
    final walkSprites = <Sprite>[];
    for (int i = 1; i <= 6; i++) {
      walkSprites.add(await gameRef.loadSprite('char/Walk/$i.png'));
    }
    final walkAnim = SpriteAnimation.spriteList(
      walkSprites,
      stepTime: 0.1,
    );

    // Membentuk animasi Jump
    final jumpSprites = <Sprite>[];
    for (int i = 1; i <= 8; i++) {
      jumpSprites.add(await gameRef.loadSprite('char/Jump/$i.png'));
    }
    final jumpAnim = SpriteAnimation.spriteList(
      jumpSprites,
      stepTime: 0.1,
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
    // Batasi maksimum dt (50ms) agar simulasi fisika tidak loncat (tunneling) saat resumeEngine()
    double safeDt = dt > 0.05 ? 0.05 : dt;
    super.update(safeDt);
    
    velocity.x = moveDirection * moveSpeed;
    velocity.y += gravity * safeDt;
    
    position += velocity * safeDt;
    
    // Safety net untuk batas bawah layar
    if (position.y > gameRef.size.y - size.y) {
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
    // Gunakan toleransi velocity untuk menghindari flickering
    if (!isOnGround && velocity.y.abs() > 10) {
      current = PlayerState.jump;
    } else if (velocity.x.abs() > 0) {
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
      // Hitung overlap di setiap sisi (AABB)
      final double overlapLeft = (position.x + size.x) - other.position.x;
      final double overlapRight = (other.position.x + other.size.x) - position.x;
      final double overlapTop = (position.y + size.y) - other.position.y;
      final double overlapBottom = (other.position.y + other.size.y) - position.y;

      // Cari arah dengan overlap terkecil (minimum penetration)
      final double minOverlapX = overlapLeft < overlapRight ? overlapLeft : overlapRight;
      final double minOverlapY = overlapTop < overlapBottom ? overlapTop : overlapBottom;

      // PERBAIKAN: Jika sedang jatuh (velocity.y >= 0), prioritaskan resolusi vertikal ke atas.
      // Kita beri sedikit toleransi (minOverlapX + 15) agar pemain lebih stabil mendarat 
      // daripada terdorong ke samping saat berada di ujung platform.
      if (velocity.y >= 0 && overlapTop < minOverlapX + 15) {
        position.y = other.position.y - size.y;
        velocity.y = 0;
        isOnGround = true;
        jumpsRemaining = 2;
        return;
      }

      if (minOverlapX < minOverlapY) {
        // Resolusi horizontal (kiri/kanan)
        if (overlapLeft < overlapRight) {
          position.x = other.position.x - size.x;
        } else {
          position.x = other.position.x + other.size.x;
        }
        velocity.x = 0;
      } else {
        // Resolusi vertikal (atas/bawah)
        if (overlapTop < overlapBottom) {
          // Player mendarat di atas platform
          position.y = other.position.y - size.y;
          velocity.y = 0;
          isOnGround = true;
          jumpsRemaining = 2;
        } else {
          // Player menabrak platform dari bawah (kena kepala)
          position.y = other.position.y + other.size.y;
          velocity.y = 0;
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
    if (other is Ground) {
      // Hanya set isOnGround false jika player memang bergerak ke atas (melompat)
      // atau jika posisi kaki sudah benar-benar di atas platform
      if (velocity.y < 0 || (position.y + size.y) < other.position.y) {
        isOnGround = false;
      }
    }
  }
}
