import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';

class VisualNovelGame extends FlameGame {
  SpriteComponent? _background;
  SpriteComponent? _characterLeft;
  SpriteComponent? _characterRight;

  String? _currentBgId;
  String? _currentCharLeftId;
  String? _currentCharRightId;

  // Configuration
  static const String assetPrefix = 'vn/';

  @override
  Color backgroundColor() => Colors.black;

  @override
  Future<void> onLoad() async {
    // Initial load can be empty
  }

  Future<void> updateScene({
    required String? bgId,
    String? charLeftId,
    String? charRightId,
  }) async {
    // Update Background
    if (bgId != null && bgId != _currentBgId) {
      _currentBgId = bgId;
      if (_background != null) {
        remove(_background!);
      }
      final sprite = await loadSprite('$assetPrefix$bgId');
      _background = SpriteComponent(sprite: sprite, size: size);
      add(_background!);
    }

    // Update Left Character
    if (charLeftId != _currentCharLeftId) {
      _currentCharLeftId = charLeftId;
      if (_characterLeft != null) {
        remove(_characterLeft!);
        _characterLeft = null;
      }
      if (charLeftId != null && charLeftId.isNotEmpty) {
        final sprite = await loadSprite('$assetPrefix$charLeftId');
        final charSize = _calculateCharSize(sprite, size);
        _characterLeft = SpriteComponent(
          sprite: sprite,
          size: charSize,
          position: Vector2(size.x * 0.05, size.y - charSize.y),
        );
        _addBreathingEffect(_characterLeft!);
        add(_characterLeft!);
      }
    }

    // Update Right Character
    if (charRightId != _currentCharRightId) {
      _currentCharRightId = charRightId;
      if (_characterRight != null) {
        remove(_characterRight!);
        _characterRight = null;
      }
      if (charRightId != null && charRightId.isNotEmpty) {
        final sprite = await loadSprite('$assetPrefix$charRightId');
        final charSize = _calculateCharSize(sprite, size);
        _characterRight = SpriteComponent(
          sprite: sprite,
          size: charSize,
          position: Vector2(size.x * 0.95 - charSize.x, size.y - charSize.y),
        );
        _addBreathingEffect(_characterRight!);
        add(_characterRight!);
      }
    }

    // Ensure background is behind characters
    if (_background != null) {
      _background!.priority = 0;
    }
    if (_characterLeft != null) {
      _characterLeft!.priority = 1;
    }
    if (_characterRight != null) {
      _characterRight!.priority = 1;
    }
  }

  void _addBreathingEffect(SpriteComponent component) {
    component.add(
      MoveEffect.by(
        Vector2(0, -10),
        EffectController(
          duration: 1.5,
          reverseDuration: 1.5,
          infinite: true,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  Vector2 _calculateCharSize(Sprite sprite, Vector2 gameSize) {
    final aspectRatio = sprite.srcSize.x / sprite.srcSize.y;
    double targetHeight = gameSize.y * 0.85; // Slightly taller for better focus
    double targetWidth = targetHeight * aspectRatio;

    // Constrain width to 45% of screen
    if (targetWidth > gameSize.x * 0.45) {
      targetWidth = gameSize.x * 0.45;
      targetHeight = targetWidth / aspectRatio;
    }

    return Vector2(targetWidth, targetHeight);
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (_background != null) {
      _background!.size = size;
    }

    if (_characterLeft != null && _characterLeft!.sprite != null) {
      final newSize = _calculateCharSize(_characterLeft!.sprite!, size);
      _characterLeft!.size = newSize;
      _characterLeft!.position = Vector2(size.x * 0.05, size.y - newSize.y);
    }
    if (_characterRight != null && _characterRight!.sprite != null) {
      final newSize = _calculateCharSize(_characterRight!.sprite!, size);
      _characterRight!.size = newSize;
      _characterRight!.position = Vector2(
        size.x * 0.95 - newSize.x,
        size.y - newSize.y,
      );
    }
  }
}
