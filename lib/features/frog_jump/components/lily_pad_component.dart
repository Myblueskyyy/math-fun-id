import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class LilyPadComponent extends SpriteComponent with TapCallbacks {
  final String label;
  final int index;
  String? optionText;
  final VoidCallback onTapDownAction;
  
  late TextComponent labelTextComponent;
  late TextComponent optionTextComponent;
  late CircleComponent labelCircle;

  LilyPadComponent({
    required Sprite sprite,
    required Vector2 position,
    required Vector2 size,
    required this.label,
    required this.index,
    required this.onTapDownAction,
    this.optionText,
  }) : super(sprite: sprite, position: position, size: size, anchor: Anchor.center);

  @override
  Future<void> onLoad() async {
    // Add green circle for the label (A, B, or C)
    labelCircle = CircleComponent(
      radius: 12,
      paint: Paint()..color = Colors.green,
      position: Vector2(size.x / 2, 0),
      anchor: Anchor.center,
    );
    add(labelCircle);

    final labelPaint = TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );

    labelTextComponent = TextComponent(
      text: label,
      textRenderer: labelPaint,
      position: Vector2(labelCircle.size.x / 2, labelCircle.size.y / 2),
      anchor: Anchor.center,
    );
    labelCircle.add(labelTextComponent);

    // Option text (e.g. "Rp 260.000")
    final optionPaint = TextPaint(
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
        shadows: [
          Shadow(blurRadius: 8, color: Colors.black, offset: Offset(2, 2)),
          Shadow(blurRadius: 8, color: Colors.black, offset: Offset(-2, -2)),
        ],
      ),
    );

    optionTextComponent = TextComponent(
      text: optionText ?? '',
      textRenderer: optionPaint,
      position: Vector2(size.x / 2, size.y / 2),
      anchor: Anchor.center,
      priority: 10,
    );
    add(optionTextComponent);
  }

  void updateText(String newText) {
    optionText = newText;
    optionTextComponent.text = newText;
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTapDownAction();
  }
}
