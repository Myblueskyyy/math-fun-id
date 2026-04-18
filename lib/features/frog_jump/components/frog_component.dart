import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/audio_controller.dart';

enum FrogState { idle, jumping, dying }

class FrogComponent extends SpriteAnimationGroupComponent<FrogState> {
  bool isJumping = false;

  FrogComponent({
    required Map<FrogState, SpriteAnimation> animations,
    required Vector2 position,
    required Vector2 size,
  }) : super(
          animations: animations,
          current: FrogState.idle,
          position: position,
          size: size,
          anchor: Anchor.center,
        );

  void jumpTo(Vector2 targetPosition, VoidCallback onComplete) {
    if (isJumping) return;
    isJumping = true;
    current = FrogState.jumping;
    AudioController.instance.playSfx('jump_frog.mp3');

    // Jump effect (arc)
    final jumpPath = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(
        (targetPosition.x - position.x) / 2,
        -100, // Peak height
        targetPosition.x - position.x,
        targetPosition.y - position.y,
      );

    add(
      MoveAlongPathEffect(
        jumpPath,
        EffectController(duration: 0.6, curve: Curves.easeInOut),
        onComplete: () {
          isJumping = false;
          // Don't switch back to idle immediately if we are going to die or stay on lilypad
          // The game logic will handle the next state
          onComplete();
        },
      ),
    );

    // Scaling effect to simulate jump
    add(
      SequenceEffect([
        ScaleEffect.by(Vector2.all(1.2), EffectController(duration: 0.3)),
        ScaleEffect.to(Vector2.all(1.0), EffectController(duration: 0.3)),
      ]),
    );
  }

  void fallInWater(VoidCallback onComplete) {
    current = FrogState.dying;
    AudioController.instance.playSfx('frog_fall_watersplash.mp3');
    // Sinking effect
    add(
      SequenceEffect([
        ScaleEffect.to(Vector2.all(0.5), EffectController(duration: 0.5)),
        OpacityEffect.to(0, EffectController(duration: 0.5)),
      ], onComplete: onComplete),
    );
  }

  void reset(Vector2 startPosition) {
    position = startPosition;
    opacity = 1.0;
    scale = Vector2.all(1.0);
    isJumping = false;
    current = FrogState.idle;
  }
}
