import 'package:flutter/material.dart';
import 'dart:async';

// needed for DateTime
void main() => runApp(const ClockApp());

// kicks everything off
class ClockApp extends StatelessWidget {
  const ClockApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Digital Clock',
      debugShowCheckedModeBanner: false,
      home: const ClockHome(),
    );
  }
}

// main screen — stateful because the clock ticks every second
class ClockHome extends StatefulWidget {
  const ClockHome({super.key});

  @override
  State<ClockHome> createState() => _ClockHomeState();
}

class _ClockHomeState extends State<ClockHome> {
  late DateTime _now;
  late Timer _timer;

  // pink or blue — starts pink
  bool _isPink = true;

  @override
  void initState() {
    super.initState();
    _now = DateTime.now();
    // tick every second
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel(); // don't leak the timer
    super.dispose();
  }

  // formats hour into 12-hr with leading zero
  String _formatHour(int h) {
    final h12 = h % 12 == 0 ? 12 : h % 12;
    return h12.toString().padLeft(2, '0');
  }

  String _twoDigit(int n) => n.toString().padLeft(2, '0');

  // am or pm — simple
  String get _period => _now.hour < 12 ? 'AM' : 'PM';

  // HH:MM:SS
  String get _timeString =>
      '${_formatHour(_now.hour)}:${_twoDigit(_now.minute)}:${_twoDigit(_now.second)}';

  // DD-MM-YYYY
  String get _dateString =>
      '${_twoDigit(_now.day)}-${_twoDigit(_now.month)}-${_now.year}';

  @override
  Widget build(BuildContext context) {
    // swap colors based on selection
    final bg = _isPink
        ? const Color(0xFFF8BBD0) // soft pink
        : const Color(0xFFBBDEFB); // soft blue

    final accent = _isPink
        ? const Color(0xFFAD1457) // deep pink
        : const Color(0xFF1565C0); // deep blue

    return Scaffold(
      // app bar matches current theme
      appBar: AppBar(
        backgroundColor: accent,
        centerTitle: true,
        title: const Text(
          'Digital Clock',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),

      body: AnimatedContainer(
        duration: const Duration(milliseconds: 400), // smooth bg switch
        color: bg,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // clock card
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 36, vertical: 28),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: accent, width: 2.5),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.25),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // the big time display
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _timeString,
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.bold,
                            color: accent,
                            letterSpacing: 4,
                            fontFeatures: const [
                              // monospaced digits so it doesn't jitter
                              FontFeature.tabularFigures()
                            ],
                          ),
                        ),
                        const SizedBox(width: 8),
                        // AM / PM badge
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              _period,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // date below the time
                    Text(
                      _dateString,
                      style: TextStyle(
                        fontSize: 22,
                        color: accent.withOpacity(0.8),
                        letterSpacing: 2,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // colour picker row
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Theme:',
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(width: 16),

                  // Pink button
                  _ThemeButton(
                    label: 'Pink',
                    color: const Color(0xFFAD1457),
                    selected: _isPink,
                    onTap: () => setState(() => _isPink = true),
                  ),

                  const SizedBox(width: 12),

                  // Blue button
                  _ThemeButton(
                    label: 'Blue',
                    color: const Color(0xFF1565C0),
                    selected: !_isPink,
                    onTap: () => setState(() => _isPink = false),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// reusable theme selection button
class _ThemeButton extends StatelessWidget {
  final String label;
  final Color color;
  final bool selected; // is this the active choice?
  final VoidCallback onTap;

  const _ThemeButton({
    required this.label,
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding:
            const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? color : Colors.white,
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(30),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.35),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : color,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}
