// Import Flutter material design package
import 'package:flutter/material.dart';

// Import async package for using Timer
import 'dart:async';

// Main function – entry point of the Flutter application
void main() => runApp(const StopwatchApp());

// Root widget of the app (stateless)
class StopwatchApp extends StatelessWidget {
  const StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Stopwatch', // App title
      home: const StopwatchPage(), // Home screen widget
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
      ),
    );
  }
}

// Main screen of the stopwatch app – stateful widget
class StopwatchPage extends StatefulWidget {
  const StopwatchPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _StopwatchPageState createState() => _StopwatchPageState();
}

// State class that holds stopwatch logic and UI state
class _StopwatchPageState extends State<StopwatchPage> {

  // Total elapsed time stored in seconds
  int _elapsedSeconds = 0;

  // Timer object to update time periodically
  Timer? _timer;

  // Flag to indicate whether stopwatch is running
  bool _isRunning = false;

  // Function to start the stopwatch
  void _start() {
    // If already running, do nothing
    if (_isRunning) return;

    _isRunning = true;

    // Create a periodic timer that ticks every 1 second
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        _elapsedSeconds++;          // Increase total elapsed time
      });
    });
  }

  // Function to stop/pause the stopwatch
  void _stop() {
    if (_timer != null) {
      _timer!.cancel();             // Cancel the timer
      _timer = null;
    }
    _isRunning = false;
  }

  // Function to reset the stopwatch
  void _reset() {
    _stop();                        // Stop the timer if running
    setState(() {
      _elapsedSeconds = 0;          // Reset time to zero
    });
  }

  // Helper function to format elapsed time as HH:MM:SS string
  String _formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;

    String twoDigits(int n) => n.toString().padLeft(2, '0');

    return '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}';
  }

  @override
  void dispose() {
    // Cancel timer when widget is disposed to avoid memory leaks
    _stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides basic visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Stopwatch'),
      ),
      body: Center(
        // Column to place time display and control buttons vertically
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display area for elapsed time
            Text(
              _formatTime(_elapsedSeconds), // Show formatted time
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),

            const SizedBox(height: 40),

            // Row containing START, STOP, RESET buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // START button
                ElevatedButton(
                  onPressed: _start,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text('START'),
                ),

                const SizedBox(width: 16),

                // STOP button
                ElevatedButton(
                  onPressed: _stop,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text('STOP'),
                ),

                const SizedBox(width: 16),

                // RESET button
                ElevatedButton(
                  onPressed: _reset,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text('RESET'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
