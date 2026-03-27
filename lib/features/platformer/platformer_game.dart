import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'components/player.dart';
import 'components/ground.dart';
import 'components/question_item.dart';

class PlatformerGame extends FlameGame with HasCollisionDetection {
  late Player player;
  int itemsCollected = 0;
  final int totalItems = 3;

  final void Function(int itemIndex) onQuestionTriggered;
  final VoidCallback onGameCompleted;

  PlatformerGame({
    required this.onQuestionTriggered,
    required this.onGameCompleted,
  });

  @override
  Future<void> onLoad() async {
    debugMode = true;
    images.prefix = 'assets/';

    // Tambah background
    final bgSprite = await loadSprite('clouds/1.png');
    add(SpriteComponent(sprite: bgSprite, size: size));

    // Platform dasar (lantai)
    add(Ground(position: Vector2(0, size.y - 40), size: Vector2(size.x, 40)));

    // Platform melayang
    add(Ground(position: Vector2(100, size.y - 150), size: Vector2(100, 20)));
    add(Ground(position: Vector2(300, size.y - 250), size: Vector2(100, 20)));
    add(Ground(position: Vector2(500, size.y - 180), size: Vector2(100, 20)));

    // Pertanyaan (Items)
    add(QuestionItem(itemIndex: 0, position: Vector2(135, size.y - 190)));
    add(QuestionItem(itemIndex: 1, position: Vector2(335, size.y - 290)));
    add(QuestionItem(itemIndex: 2, position: Vector2(550, size.y - 220)));

    // Player
    player = Player(position: Vector2(20, size.y - 100));
    add(player);
  }

  void triggerQuestion(int itemIndex) {
    // Bekukan state player sebelum pause agar tidak jatuh saat resume
    player.velocity = Vector2.zero();
    player.moveDirection = 0;
    pauseEngine();
    onQuestionTriggered(itemIndex);
  }

  void moveLeft() {
    if (isLoaded) player.moveDirection = -1;
  }

  void moveRight() {
    if (isLoaded) player.moveDirection = 1;
  }

  void stopMoving() {
    if (isLoaded) player.moveDirection = 0;
  }

  void jump() {
    if (isLoaded) player.jump();
  }

  void answerCorrectly() {
    itemsCollected++;
    // Pastikan player stabil sebelum resume
    player.velocity = Vector2.zero();
    player.moveDirection = 0;
    resumeEngine();
    if (itemsCollected >= totalItems) {
      onGameCompleted();
    }
  }
}
