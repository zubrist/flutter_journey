import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AudioPlayerScreen(),
    );
  }
}

class AudioPlayerScreen extends StatefulWidget {
  const AudioPlayerScreen({super.key});

  @override
  State<AudioPlayerScreen> createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  late final AudioPlayer _player;
  bool _isReady = false;
  String? _errorMessage;
  final String _songName = 'Sample Song';

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    _init();
  }

  Future<void> _init() async {
    try {
      // For Flutter Web, use the direct asset URL path
      await _player
          .setUrl('assets/audio/sample_song.mp3')
          .timeout(const Duration(seconds: 10));
      if (mounted) {
        setState(() {
          _isReady = true;
          _errorMessage = null;
        });
      }
    } catch (e) {
      // If asset fails, log the error and show an error state
      print('Error loading audio: $e');
      if (mounted) {
        setState(() {
          _isReady = true; // Still set ready to show error message
          _errorMessage = 'Error loading audio: $e';
        });
      }
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Web Audio Player'),
      ),
      body: Center(
        child: !_isReady
            ? const CircularProgressIndicator()
            : _errorMessage != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error, size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        _errorMessage ?? 'Unknown error',
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _isReady = false;
                            _errorMessage = null;
                          });
                          _init();
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Music Banner
                        Container(
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            children: [
                              const Icon(
                                Icons.music_note,
                                size: 80,
                                color: Colors.white,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                _songName,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 40),
                        // Player Controls and Progress
                        StreamBuilder<PlayerState>(
                          stream: _player.playerStateStream,
                          builder: (context, snapshot) {
                            final playerState = snapshot.data;
                            final processingState = playerState?.processingState;
                            final playing = playerState?.playing ?? false;

                            if (processingState == ProcessingState.loading ||
                                processingState == ProcessingState.buffering) {
                              return const CircularProgressIndicator();
                            }

                            return Column(
                              children: [
                                // Progress Bar and Time
                                StreamBuilder<Duration>(
                                  stream: _player.positionStream,
                                  builder: (context, snapshot) {
                                    final position = snapshot.data ?? Duration.zero;
                                    final duration =
                                        _player.duration ?? Duration.zero;

                                    return Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Progress Bar
                                        LinearProgressIndicator(
                                          value: duration.inMilliseconds > 0
                                              ? position.inMilliseconds /
                                                  duration.inMilliseconds
                                              : 0,
                                          minHeight: 6,
                                          backgroundColor: Colors.grey[300],
                                          valueColor:
                                              const AlwaysStoppedAnimation<Color>(
                                                Colors.blueAccent,
                                              ),
                                        ),
                                        const SizedBox(height: 12),
                                        // Time Display
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              _formatDuration(position),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              _formatDuration(duration),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                const SizedBox(height: 32),
                                // Play/Pause with Next/Previous Buttons
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Previous Button (Skip Back 10s)
                                    ElevatedButton(
                                      onPressed: () async {
                                        final currentPos = _player.position;
                                        final newPos = currentPos.inSeconds > 10
                                            ? Duration(
                                                seconds:
                                                    currentPos.inSeconds - 10)
                                            : Duration.zero;
                                        await _player.seek(newPos);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(12),
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.grey[400],
                                      ),
                                      child: const Icon(
                                        Icons.skip_previous,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Play/Pause Button
                                    ElevatedButton(
                                      onPressed: playing
                                          ? _player.pause
                                          : _player.play,
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(16),
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.blueAccent,
                                      ),
                                      child: Icon(
                                        playing
                                            ? Icons.pause
                                            : Icons.play_arrow,
                                        size: 40,
                                        color: Colors.white,
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    // Next Button (Skip Forward 10s)
                                    ElevatedButton(
                                      onPressed: () async {
                                        final currentPos = _player.position;
                                        final duration =
                                            _player.duration ?? Duration.zero;
                                        final newPos = currentPos.inSeconds <
                                                duration.inSeconds - 10
                                            ? Duration(
                                                seconds:
                                                    currentPos.inSeconds + 10)
                                            : duration;
                                        await _player.seek(newPos);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        padding: const EdgeInsets.all(12),
                                        shape: const CircleBorder(),
                                        backgroundColor: Colors.grey[400],
                                      ),
                                      child: const Icon(
                                        Icons.skip_next,
                                        size: 28,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}