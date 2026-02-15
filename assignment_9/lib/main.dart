// Import Flutter material design package
import 'package:flutter/material.dart';

// Import audioplayers package for playing audio files
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

// Main function – entry point of the Flutter application
void main() => runApp(const MusicPlayerApp());

// Root widget of the app (stateless)
class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Music Player',
      home: MusicPlayerHome(), // Home screen widget
      debugShowCheckedModeBanner: false,
    );
  }
}

// Main screen – stateful widget because music state changes dynamically
class MusicPlayerHome extends StatefulWidget {
  const MusicPlayerHome({super.key});

  @override
  State<MusicPlayerHome> createState() => _MusicPlayerHomeState();
}

// State class that holds list of songs and playback logic
class _MusicPlayerHomeState extends State<MusicPlayerHome> {
  // Audio player instance from audioplayers package
  final AudioPlayer _audioPlayer = AudioPlayer();

  // List of song titles
  final List<String> _songTitles = <String>[
    'Song 1',
    'Song 2',
    'Song 3',
  ];

  // Corresponding list of asset paths for the songs
  final List<String> _songPaths = <String>[
    'assets/audio/song1.mp3',
    'assets/audio/song2.mp3',
    'assets/audio/song3.mp3',
  ];

  // Index of the currently selected/playing song
  int _currentIndex = 0;

  // Flag to track whether a song is currently playing
  bool _isPlaying = false;

  // Function to play song at given index
  Future<void> _playSong(int index) async {
    _currentIndex = index;

    // Stop any currently playing audio before starting new one
    await _audioPlayer.stop();

    // Play audio from asset by writing it to a temporary file and playing that file.
    // This avoids referring to Source classes that may not exist across audioplayers versions.
    try {
      final byteData = await rootBundle.load(_songPaths[index]);
      final bytes = byteData.buffer.asUint8List();
      final tempDir = Directory.systemTemp;
      final fileName = '${DateTime.now().millisecondsSinceEpoch}_${_songPaths[index].split('/').last}';
      final file = await File('${tempDir.path}/$fileName').writeAsBytes(bytes, flush: true);
      // Play from the local device file using DeviceFileSource
      await _audioPlayer.play(DeviceFileSource(file.path));
    } catch (e) {
      // If this fails, print error and rethrow for the caller to handle
      // ignore: avoid_print
      print('Failed to play asset ${_songPaths[index]}: $e');
      rethrow;
    }

    setState(() {
      _isPlaying = true;
    });
  }

  // Function to pause the current song
  Future<void> _pauseSong() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  // Function to resume the paused song
  Future<void> _resumeSong() async {
    await _audioPlayer.resume();
    setState(() {
      _isPlaying = true;
    });
  }

  // Function to play the next song in the list
  Future<void> _playNext() async {
    int nextIndex = _currentIndex + 1;
    if (nextIndex >= _songPaths.length) {
      nextIndex = 0; // Wrap around to first song
    }
    await _playSong(nextIndex);
  }

  // Function to play the previous song in the list
  Future<void> _playPrevious() async {
    int prevIndex = _currentIndex - 1;
    if (prevIndex < 0) {
      prevIndex = _songPaths.length - 1; // Wrap to last song
    }
    await _playSong(prevIndex);
  }

  @override
  void dispose() {
    // Release resources when widget is disposed
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides basic visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: Column(
        children: [
          // Expanded ListView to show available songs
          Expanded(
            child: ListView.builder(
              itemCount: _songTitles.length,
              itemBuilder: (BuildContext context, int index) {
                final bool isSelected = index == _currentIndex;
                return ListTile(
                  title: Text(_songTitles[index]),
                  leading: Icon(
                    Icons.music_note,
                    color: isSelected ? Colors.blue : Colors.grey,
                  ),
                  selected: isSelected,
                  onTap: () => _playSong(index), // Play tapped song
                );
              },
            ),
          ),

          const Divider(),

          // Now playing and control buttons
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                // Display current song title
                Text(
                  'Now Playing: ${_songTitles[_currentIndex]}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                // Row of control buttons: Previous, Play/Pause, Next
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      iconSize: 32,
                      icon: const Icon(Icons.skip_previous),
                      onPressed: _playPrevious,
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      iconSize: 40,
                      icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
                      onPressed: () {
                        if (_isPlaying) {
                          _pauseSong();
                        } else {
                          _resumeSong();
                        }
                      },
                    ),
                    const SizedBox(width: 16),
                    IconButton(
                      iconSize: 32,
                      icon: const Icon(Icons.skip_next),
                      onPressed: _playNext,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
