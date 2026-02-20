abstract class AudioControllerBase {
  Future<void> playAsset(String assetPath);
  Future<void> pause();
  Future<void> resume();
  Future<void> stop();
  void dispose();
}
