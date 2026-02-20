import 'player_base.dart';

/// IO implementation (mobile/desktop) - lightweight stub.
/// You can replace this with a real implementation using `audioplayers` or
/// another package for native platforms later.
class AudioControllerImpl implements AudioControllerBase {
  AudioControllerImpl();

  @override
  Future<void> playAsset(String assetPath) async {
    // No-op on non-web by default. Implement with `audioplayers` for native platforms.
    return Future.value();
  }

  @override
  Future<void> pause() async {
    return Future.value();
  }

  @override
  Future<void> resume() async {
    return Future.value();
  }

  @override
  Future<void> stop() async {
    return Future.value();
  }

  @override
  void dispose() {}
}
