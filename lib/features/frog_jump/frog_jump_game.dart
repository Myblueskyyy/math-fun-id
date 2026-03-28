import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import 'components/frog_component.dart';
import 'components/lily_pad_component.dart';

class FrogJumpGame extends FlameGame with TapCallbacks {
  late FrogComponent frog;
  late List<LilyPadComponent> lilyPads = [];
  
  final void Function(int selectedIndex) onLilyPadSelected;
  final VoidCallback onReset;

  FrogJumpGame({
    required this.onLilyPadSelected,
    required this.onReset,
  });

  @override
  Future<void> onLoad() async {
    debugMode = false;
    images.prefix = ''; // We use full paths from assets/

    // Add water background
    final bgSprite = await loadSprite('assets/images/frog_jump/pond_bg.png');
    add(SpriteComponent(sprite: bgSprite, size: size));

    // Position lily pads in a row at the top
    final lilyPadSprite = await loadSprite('assets/images/frog_jump/lily_pad.png');
    final spacing = size.x / 4;
    
    for (int i = 0; i < 3; i++) {
      final lp = LilyPadComponent(
        sprite: lilyPadSprite,
        position: Vector2(spacing * (i + 1), size.y * 0.3),
        size: Vector2(100, 80),
        label: i == 0 ? 'A' : (i == 1 ? 'B' : 'C'),
        index: i,
        onTapDownAction: () {
          if (!frog.isJumping) {
            onLilyPadSelected(i);
          }
        },
      );
      lilyPads.add(lp);
      add(lp);
    }

    // Add frog at bottom center
    final frogSprite = await loadSprite('assets/images/frog_jump/frog_idle.png');
    frog = FrogComponent(
      sprite: frogSprite,
      position: Vector2(size.x / 2, size.y * 0.8),
      size: Vector2(80, 80),
    );
    add(frog);
  }

  void jumpToLilyPad(int index, bool isCorrect, VoidCallback onFinish) {
    final target = lilyPads[index].position;
    frog.jumpTo(target, () {
      if (!isCorrect) {
        frog.fallInWater(() {
          onFinish();
        });
      } else {
        // Stay on lily pad for a bit then reset or move to next
        Future.delayed(const Duration(milliseconds: 500), () {
          onFinish();
        });
      }
    });
  }

  void resetFrog() {
    frog.reset(Vector2(size.x / 2, size.y * 0.8));
    onReset();
  }
}
