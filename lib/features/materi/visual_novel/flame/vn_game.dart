import 'package:flame/components.dart';
import 'package:flame/game.dart';
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
        // Position at bottom left
        final charSize = Vector2(size.x * 0.4, size.y * 0.7);
        _characterLeft = SpriteComponent(
          sprite: sprite,
          size: charSize,
          position: Vector2(size.x * 0.1, size.y - charSize.y),
        );
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
        // Position at bottom right
        final charSize = Vector2(size.x * 0.4, size.y * 0.7);
        _characterRight = SpriteComponent(
          sprite: sprite,
          size: charSize,
          position: Vector2(size.x * 0.5, size.y - charSize.y),
        );
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

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    if (_background != null) {
      _background!.size = size;
    }

    final charSize = Vector2(size.x * 0.4, size.y * 0.7);
    if (_characterLeft != null) {
      _characterLeft!.size = charSize;
      _characterLeft!.position = Vector2(size.x * 0.1, size.y - charSize.y);
    }
    if (_characterRight != null) {
      _characterRight!.size = charSize;
      _characterRight!.position = Vector2(size.x * 0.5, size.y - charSize.y);
    }
  }
}
