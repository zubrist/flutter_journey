import 'dart:html' as html;
import 'player_base.dart';

/// Web implementation using `AudioElement`.
class AudioControllerImpl implements AudioControllerBase {
  html.AudioElement? _audio;

  AudioControllerImpl();

  @override
  Future<void> playAsset(String assetPath) async {
    try {
      _audio?.pause();
      _audio = html.AudioElement(assetPath)
        ..autoplay = true
        ..controls = false;
      // Wait for play promise
      await _audio!.play();
    } catch (e) {
      // ignore errors (e.g., user gesture required)
    }
  }

  @override
  Future<void> pause() async {
    _audio?.pause();
  }

  @override
  Future<void> resume() async {
    try {
      await _audio?.play();
    } catch (_) {}
  }

  @override
  Future<void> stop() async {
    _audio?.pause();
    if (_audio != null) {
      _audio!.currentTime = 0;
    }
  }

  @override
  void dispose() {
    _audio?.pause();
    _audio = null;
  }
}
