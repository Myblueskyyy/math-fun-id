import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class AudioController {
  static final AudioController _instance = AudioController._internal();
  static AudioController get instance => _instance;

  final AudioPlayer _bgmPlayer = AudioPlayer();

  String? _currentBgm;
  double _bgmVolume = 0.0;
  Timer? _fadeTimer;

  AudioController._internal() {
    _bgmPlayer.setReleaseMode(ReleaseMode.loop);
  }

  // Fade parameters
  static const int _fadeSteps = 20;
  static const int _fadeDurationMs = 500;

  Future<void> playBgm(String assetPath, {double targetVolume = 0.5}) async {
    if (_currentBgm == assetPath) {
      if (_bgmVolume != targetVolume) {
        fadeToVolume(targetVolume);
      }
      return;
    }

    // Fade out current BGM if playing
    if (_currentBgm != null && _bgmPlayer.state == PlayerState.playing) {
      await _fadeOut();
    }

    try {
      _currentBgm = assetPath;
      _bgmVolume = 0.0;
      await _bgmPlayer.setVolume(_bgmVolume);
      await _bgmPlayer.play(AssetSource('sounds/$assetPath'));
      await _fadeIn(targetVolume);
    } catch (e) {
      print('Error playing BGM $assetPath: $e');
    }
  }

  Future<void> fadeToVolume(double targetVolume) async {
    _fadeTimer?.cancel();
    final double startVolume = _bgmVolume;
    final double difference = targetVolume - startVolume;
    if (difference == 0) return;

    final double step = difference / _fadeSteps;
    final int stepDuration = _fadeDurationMs ~/ _fadeSteps;
    int currentStep = 0;

    final completer = Completer<void>();

    _fadeTimer = Timer.periodic(Duration(milliseconds: stepDuration), (timer) {
      currentStep++;
      _bgmVolume = startVolume + (step * currentStep);

      // Prevent overshoot due to floating point precision
      if ((step > 0 && _bgmVolume > targetVolume) ||
          (step < 0 && _bgmVolume < targetVolume)) {
        _bgmVolume = targetVolume;
      }

      _bgmPlayer.setVolume(_bgmVolume);

      if (currentStep >= _fadeSteps || _bgmVolume == targetVolume) {
        timer.cancel();
        if (!completer.isCompleted) completer.complete();
      }
    });

    return completer.future;
  }

  Future<void> _fadeOut() async {
    await fadeToVolume(0.0);
    await _bgmPlayer.stop();
  }

  Future<void> _fadeIn(double targetVolume) async {
    await fadeToVolume(targetVolume);
  }

  Future<void> playSfx(String assetPath) async {
    try {
      // Generate short-lived player to prevent overlapping sfx interruption
      final player = AudioPlayer();
      player.onPlayerComplete.listen((_) => player.dispose());
      // Fallback if dispose fails: destroy after somewhat safe time
      Future.delayed(const Duration(seconds: 5), () => player.dispose());
      await player.play(AssetSource('sounds/$assetPath'));
    } catch (e) {
      print('Error playing SFX $assetPath: $e');
    }
  }

  Future<void> playButtonClick() async {
    await playSfx('button_click.mp3');
  }

  void stopAll() {
    _bgmPlayer.stop();
    _currentBgm = null;
  }
}
