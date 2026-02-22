import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MusicPlayerApp());

class MusicPlayerApp extends StatelessWidget {
  const MusicPlayerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const MusicHome(),
    );
  }
}

class MusicHome extends StatefulWidget {
  const MusicHome({super.key});

  @override
  State<MusicHome> createState() => _MusicHomeState();
}

class _MusicHomeState extends State<MusicHome> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final List<Song> _playlist = [
    const Song(
      title: 'Sample Song',
      artist: 'Local Demo',
      assetPath: 'assets/audio/sample_song.mp3',
    ),
  ];

  int _currentIndex = 0;
  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;
  bool _isSeeking = false;

  Song get _currentSong => _playlist[_currentIndex];

  @override
  void initState() {
    super.initState();
    _wirePlayerEvents();
    _loadTrack();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _wirePlayerEvents() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() => _isPlaying = state == PlayerState.playing);
    });

    _audioPlayer.onDurationChanged.listen((duration) {
      if (!mounted) return;
      setState(() => _duration = duration);
    });

    _audioPlayer.onPositionChanged.listen((position) {
      if (!mounted || _isSeeking) return;
      setState(() => _position = position);
    });

    _audioPlayer.onPlayerComplete.listen((_) => _handleNext());
  }

  Future<void> _loadTrack({bool autoPlay = false}) async {
    try {
      final source = _currentSong.audioSource;
      setState(() {
        _duration = Duration.zero;
        _position = Duration.zero;
      });
      await _audioPlayer.setSource(source);
      if (autoPlay) {
        await _audioPlayer.resume();
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not load ${_currentSong.title}: $error')),
      );
    }
  }

  Future<void> _handlePlayPause() async {
    if (_isPlaying) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  Future<void> _handleNext() async {
    if (_playlist.isEmpty || !mounted) return;
    setState(() => _currentIndex = (_currentIndex + 1) % _playlist.length);
    await _loadTrack(autoPlay: _isPlaying);
  }

  Future<void> _handlePrevious() async {
    if (_playlist.isEmpty || !mounted) return;
    setState(() =>
        _currentIndex = (_currentIndex - 1 + _playlist.length) % _playlist.length);
    await _loadTrack(autoPlay: _isPlaying);
  }

  Future<void> _seekTo(double milliseconds) async {
    final target = Duration(milliseconds: milliseconds.round());
    await _audioPlayer.seek(target);
    setState(() => _position = target);
  }

  Future<void> _importFromDevice() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
      allowMultiple: false,
    );

    if (result == null || result.files.isEmpty) return;
    final file = result.files.first;
    if (file.path == null) return;

    setState(() {
      final userSong = Song(
        title: file.name,
        artist: 'Device',
        filePath: file.path,
      );
      _playlist.add(userSong);
      _currentIndex = _playlist.length - 1;
    });

    if (!mounted) return;
    await _loadTrack(autoPlay: true);
  }

  @override
  Widget build(BuildContext context) {
    final sliderMax = max(1, _duration.inMilliseconds.toDouble());
    final sliderValue = min(sliderMax, max(0, _position.inMilliseconds.toDouble()));

    return Scaffold(
      backgroundColor: const Color(0xFF050A1A),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Music Player',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  IconButton(
                    onPressed: _importFromDevice,
                    icon: const Icon(Icons.upload_file),
                    tooltip: 'Load from device',
                  ),
                ],
              ),
              const SizedBox(height: 8),
              _NowPlayingCard(
                song: _currentSong,
                isPlaying: _isPlaying,
                duration: _duration,
                position: _position,
              ),
              const SizedBox(height: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Colors.deepPurpleAccent,
                      thumbColor: Colors.deepPurpleAccent,
                      overlayColor: Colors.deepPurpleAccent.withOpacity(0.3),
                    ),
                    child: Slider(
                      min: 0,
                      max: sliderMax,
                      value: sliderValue,
                      onChanged: (value) {
                        setState(() {
                          _position = Duration(milliseconds: value.round());
                          _isSeeking = true;
                        });
                      },
                      onChangeEnd: (value) {
                        _isSeeking = false;
                        _seekTo(value);
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatDuration(_position)),
                        Text(_formatDuration(_duration)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _ControlButton(
                    icon: Icons.skip_previous,
                    onPressed: _handlePrevious,
                  ),
                  const SizedBox(width: 12),
                  _ControlButton(
                    icon: _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    size: 72,
                    onPressed: _handlePlayPause,
                  ),
                  const SizedBox(width: 12),
                  _ControlButton(
                    icon: Icons.skip_next,
                    onPressed: _handleNext,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Playlist',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    color: Colors.white12,
                    child: ListView.separated(
                      itemCount: _playlist.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final song = _playlist[index];
                        final isActive = index == _currentIndex;
                        return ListTile(
                          onTap: () async {
                            setState(() => _currentIndex = index);
                            await _loadTrack(autoPlay: true);
                          },
                          tileColor:
                              isActive ? Colors.deepPurpleAccent.withOpacity(0.3) : null,
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
                            child: const Icon(Icons.music_note, color: Colors.white),
                          ),
                          title: Text(song.title),
                          subtitle: Text(song.artist),
                          trailing: isActive && _isPlaying
                              ? const Icon(Icons.equalizer, color: Colors.deepPurpleAccent)
                              : null,
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Song {
  const Song({
    required this.title,
    required this.artist,
    this.assetPath,
    this.filePath,
  })  : assert(assetPath != null || filePath != null,
            'Either assetPath or filePath must be provided');

  final String title;
  final String artist;
  final String? assetPath;
  final String? filePath;

  AudioSource get audioSource {
    if (filePath != null) return DeviceFileSource(filePath!);
    if (assetPath != null) return AssetSource(assetPath!);
    throw StateError('No source defined for $title');
  }
}

String _formatDuration(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

class _NowPlayingCard extends StatelessWidget {
  const _NowPlayingCard({
    required this.song,
    required this.isPlaying,
    required this.duration,
    required this.position,
  });

  final Song song;
  final bool isPlaying;
  final Duration duration;
  final Duration position;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        gradient: const LinearGradient(
          colors: [Color(0xFF1E1B4B), Color(0xFF3A0CA3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.45),
            blurRadius: 20,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Container(
            height: 90,
            width: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white24,
            ),
            child: const Icon(
              Icons.album,
              size: 42,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  song.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  song.artist,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  isPlaying ? 'Now playing' : 'Paused',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white60,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    required this.onPressed,
    this.size = 56,
  });

  final IconData icon;
  final VoidCallback onPressed;
  final double size;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(size),
      child: Ink(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white10,
        ),
        child: Icon(
          icon,
          size: size * 0.6,
          color: Colors.white,
        ),
      ),
    );
  }
}