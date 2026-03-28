import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'components/frog_component.dart';
import 'components/lily_pad_component.dart';

class FrogJumpGame extends FlameGame with TapCallbacks {
  late FrogComponent frog;
  late LilyPadComponent lpSouth;
  late LilyPadComponent lpWest;
  late LilyPadComponent lpNorth;
  late LilyPadComponent lpEast;
  late SpriteComponent waterBack;

  final void Function(int selectedIndex) onLilyPadSelected;
  final VoidCallback onReset;

  bool _isLoaded = false;
  List<String>? _pendingOptions;

  // Base positions (Cardinal)
  late Vector2 pSouth;
  late Vector2 pWest;
  late Vector2 pNorth;
  late Vector2 pEast;

  FrogJumpGame({required this.onLilyPadSelected, required this.onReset});

  @override
  Future<void> onLoad() async {
    debugMode = false;
    images.prefix = '';

    // Calculate base positions for the "South-focused" system
    // Compact layout for landscape screens
    pSouth = Vector2(size.x * 0.5, size.y * 0.82);
    pWest = Vector2(size.x * 0.3, size.y * 0.55);
    pNorth = Vector2(size.x * 0.5, size.y * 0.4);
    pEast = Vector2(size.x * 0.7, size.y * 0.55);

    // Static Water Background
    final bgSprite = await loadSprite('assets/images/water_bg.jpg');
    waterBack = SpriteComponent(
      sprite: bgSprite,
      size: size,
    );
    add(waterBack);

    final lpSprite = await loadSprite('assets/images/frog_jump/lilypad_01.png');

    // Create the 4 cardinal lily pads
    lpSouth = _createLilyPad(lpSprite, pSouth, 'S', -1, () {});
    lpWest = _createLilyPad(lpSprite, pWest, 'A', 0, () => _handleTap(0));
    lpNorth = _createLilyPad(lpSprite, pNorth, 'B', 1, () => _handleTap(1));
    lpEast = _createLilyPad(lpSprite, pEast, 'C', 2, () => _handleTap(2));

    add(lpSouth);
    add(lpWest);
    add(lpNorth);
    add(lpEast);

    // Frog
    final idleAnim = await _loadAnim('Idle', 8);
    final jumpAnim = await _loadAnim('Jump', 7, loop: false);
    final dieAnim = await _loadAnim('Die', 9, loop: false);

    frog = FrogComponent(
      animations: {
        FrogState.idle: idleAnim,
        FrogState.jumping: jumpAnim,
        FrogState.dying: dieAnim,
      },
      position: pSouth.clone(),
      size: Vector2(100, 100),
    );
    add(frog);

    _isLoaded = true;
    if (_pendingOptions != null) {
      updateOptions(_pendingOptions!);
      _pendingOptions = null;
    }
  }

  LilyPadComponent _createLilyPad(
    Sprite sprite,
    Vector2 pos,
    String label,
    int index,
    VoidCallback onTap,
  ) {
    return LilyPadComponent(
      sprite: sprite,
      position: pos.clone(),
      size: Vector2(160, 130), // Increased size
      label: label,
      index: index,
      onTapDownAction: onTap,
    );
  }

  Future<SpriteAnimation> _loadAnim(
    String name,
    int frames, {
    bool loop = true,
  }) async {
    final list = <Sprite>[];
    for (int i = 1; i <= frames; i++) {
      list.add(await loadSprite('assets/images/frog/$name/$i.png'));
    }
    return SpriteAnimation.spriteList(list, stepTime: 0.1, loop: loop);
  }

  void _handleTap(int index) {
    if (!frog.isJumping) {
      onLilyPadSelected(index);
    }
  }

  void updateOptions(List<String> options) {
    if (!_isLoaded) {
      _pendingOptions = options;
      return;
    }

    // Reveal options for the current question
    lpWest.updateText(options[0]);
    lpNorth.updateText(options[1]);
    lpEast.updateText(options[2]);

    lpWest.opacity = 1.0;
    lpNorth.opacity = 1.0;
    lpEast.opacity = 1.0;
  }

  void jumpToLilyPad(int index, bool isCorrect, VoidCallback onFinish) {
    final target = index == 0 ? lpWest : (index == 1 ? lpNorth : lpEast);

    frog.jumpTo(target.position, () {
      if (!isCorrect) {
        frog.fallInWater(onFinish);
      } else {
        _shiftWorld(target, onFinish);
      }
    });
  }

  void _shiftWorld(LilyPadComponent target, VoidCallback onFinish) async {
    final offset = pSouth - target.position;
    final duration = 0.8;

    // Shift lilypads and frog back to centered South
    final components = [lpSouth, lpWest, lpNorth, lpEast, frog];
    for (var comp in components) {
      comp.add(
        MoveByEffect(
          offset,
          EffectController(duration: duration, curve: Curves.easeInOut),
        ),
      );
    }

    // Fade out other lilypads that were not selected
    if (target != lpWest)
      lpWest.add(OpacityEffect.to(0, EffectController(duration: 0.3)));
    if (target != lpNorth)
      lpNorth.add(OpacityEffect.to(0, EffectController(duration: 0.3)));
    if (target != lpEast)
      lpEast.add(OpacityEffect.to(0, EffectController(duration: 0.3)));
    lpSouth.add(OpacityEffect.to(0, EffectController(duration: 0.3)));

    await Future.delayed(const Duration(milliseconds: 850));

    // Reset positions and state
    lpSouth.position.setFrom(pSouth);
    lpWest.position.setFrom(pWest);
    lpNorth.position.setFrom(pNorth);
    lpEast.position.setFrom(pEast);
    frog.position.setFrom(pSouth);
    frog.current = FrogState.idle;

    // TRANSFER: The South lilypad should be EMPTY as per user request
    lpSouth.updateText('');
    lpSouth.opacity = 1.0;

    // Reset other options text as well to be safe
    lpWest.updateText('');
    lpNorth.updateText('');
    lpEast.updateText('');

    // Prepare for next question (onFinish will call screen's updateOptions which will fade them back in)
    onFinish();
  }

  void resetFrog() {
    frog.reset(pSouth);
    onReset();
  }
}
