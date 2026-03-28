import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class LilyPadComponent extends SpriteComponent with TapCallbacks {
  final String label;
  final int index;
  final VoidCallback onTapDownAction;

  LilyPadComponent({
    required Sprite sprite,
    required Vector2 position,
    required Vector2 size,
    required this.label,
    required this.index,
    required this.onTapDownAction,
  }) : super(sprite: sprite, position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    // Add label (A, B, or C)
    final textPaint = TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        shadows: [Shadow(blurRadius: 4, color: Colors.black, offset: Offset(2, 2))],
      ),
    );
    
    add(
      TextComponent(
        text: label,
        textRenderer: textPaint,
        position: Vector2(size.x / 2, -20),
        anchor: Anchor.center,
      ),
    );
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTapDownAction();
  }
}
