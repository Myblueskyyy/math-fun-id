import 'dart:async';
import 'package:audioplayers/audioplayers.dart';

class AudioController {
  static final AudioController _instance = AudioController._internal();
  static AudioController get instance => _instance;

  final AudioPlayer _bgmPlayer = AudioPlayer();
  // Reusable SFX player for short effects (clicks, correct/wrong)
  final AudioPlayer _sfxPlayer = AudioPlayer();
  // Dedicated player for Voice Overs to ensure they are never cut off by SFX
  final AudioPlayer _voPlayer = AudioPlayer();

  Stream<void> get onVoComplete => _voPlayer.onPlayerComplete;
  Stream<void> get onSfxComplete => _sfxPlayer.onPlayerComplete;

  String? _currentBgm;
  double _bgmVolume = 0.0;
  Timer? _fadeTimer;


  AudioController._internal() {
    // CRITICAL: Set global audio context to mix with others.
    // Without this, each new AudioPlayer requests audio focus on Android,
    // which pauses/stops the BGM player.
    AudioPlayer.global.setAudioContext(
      AudioContextConfig(
        focus: AudioContextConfigFocus.mixWithOthers,
      ).build(),
    );

    _bgmPlayer.setReleaseMode(ReleaseMode.loop);
    _sfxPlayer.setReleaseMode(ReleaseMode.release);
    _voPlayer.setReleaseMode(ReleaseMode.release);
  }

  // Fade parameters
  static const int _fadeSteps = 20;
  static const int _fadeDurationMs = 500;

  Future<void> playBgm(String assetPath, {double targetVolume = 0.5}) async {
    // If same BGM is requested and is actually still playing, just adjust volume
    if (_currentBgm == assetPath &&
        _bgmPlayer.state == PlayerState.playing) {
      if (_bgmVolume != targetVolume) {
        fadeToVolume(targetVolume);
      }
      return;
    }

    // If same BGM is requested but player is NOT playing, restart it
    // (handles edge cases where player stopped unexpectedly)



    // Fade out current BGM if playing something different
    if (_currentBgm != null &&
        _currentBgm != assetPath &&
        _bgmPlayer.state == PlayerState.playing) {
      await _fadeOut();
    } else if (_bgmPlayer.state == PlayerState.playing) {
      // Same BGM but somehow still flagged — stop it cleanly
      await _bgmPlayer.stop();
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

  /// Ensures the main BGM is playing. Call this when returning to normal screens.
  /// This is safe to call repeatedly — it only restarts if not already playing.
  Future<void> ensureMainBgm() async {
    await playBgm('main_bgm.mp3');
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

  Future<void> playSfx(String assetPath, {double volume = 1.0}) async {
    try {
      // Use the reusable SFX player — stops any previous SFX and plays the new one
      // This avoids creating/disposing AudioPlayer instances which can steal audio focus
      await _sfxPlayer.stop();
      await _sfxPlayer.setVolume(volume);
      await _sfxPlayer.play(AssetSource('sounds/$assetPath'));
    } catch (e) {
      print('Error playing SFX $assetPath: $e');
    }
  }

  Future<void> stopSfx() async {
    await _sfxPlayer.stop();
  }

  Future<void> playVo(String assetPath) async {
    try {
      // Force volume to absolute maximum (1.0)
      await _voPlayer.stop();
      await _voPlayer.setVolume(1.0);
      await _voPlayer.play(AssetSource('sounds/$assetPath'));
      // Re-assert volume after play starts to handle potential platform resets
      await _voPlayer.setVolume(1.0);
    } catch (e) {
      print('Error playing VO $assetPath: $e');
    }
  }

  Future<void> stopVo() async {
    await _voPlayer.stop();
  }

  Future<void> playButtonClick() async {
    await playSfx('button_click.mp3');
  }

  void stopAll() {
    _fadeTimer?.cancel();
    _bgmPlayer.stop();
    _sfxPlayer.stop();
    _voPlayer.stop();
    _currentBgm = null;
    _bgmVolume = 0.0;
  }
}
