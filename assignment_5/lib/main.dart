// Import Flutter material design package
import 'package:flutter/material.dart';

// Main function – entry point of the Flutter application
void main() => runApp(const AnimatedBoxApp());

// Root widget of the app (stateless)
class AnimatedBoxApp extends StatelessWidget {
  const AnimatedBoxApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animated Container Demo', // App title
      home: const AnimatedBoxPage(), // Home screen widget
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 4,
          centerTitle: true,
          toolbarHeight: 72,
          titleTextStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(16))),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            textStyle: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }
}

// Main screen – stateful widget because box properties change
class AnimatedBoxPage extends StatefulWidget {
  const AnimatedBoxPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimatedBoxPageState createState() => _AnimatedBoxPageState();
}

// State class that holds container properties and toggling logic
class _AnimatedBoxPageState extends State<AnimatedBoxPage> {
  // Initial properties of the container
  double _width = 100.0;
  double _height = 100.0;
  Color _color = Colors.red;

  // Flag to track whether container is expanded or in initial state
  bool _isExpanded = false;

  // Function called when button is pressed to toggle animation
  void _toggleAnimation() {
    setState(() {
      if (_isExpanded) {
        // Revert to initial state: small red box
        _width = 100.0;
        _height = 100.0;
        _color = Colors.red;
      } else {
        // Change to target state: bigger blue box
        _width = 200.0;
        _height = 200.0;
        _color = Colors.blue;
      }
      // Flip the state flag
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides basic visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text('Animated Container'),
            SizedBox(height: 4),
            Text(
              'Tap the button to animate',
              style: TextStyle(fontSize: 12, color: Colors.black54),
            ),
          ],
        ),
        // no actions (removed info icon)
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // AnimatedContainer automatically animates property changes
            AnimatedContainer(
              width: _width, // Animated width
              height: _height, // Animated height
              duration: const Duration(seconds: 1), // Animation duration: 1 second
              curve: Curves.easeInOut, // Smooth animation curve
              decoration: BoxDecoration(
                color: _color,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  // soft, diffused shadow for the floating illusion
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 18,
                    offset: Offset(0, 12),
                    spreadRadius: -6,
                  ),
                  // small sharper shadow close to the box base
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Button to start the animation
            ElevatedButton(
              onPressed: _toggleAnimation, // Trigger animation on press
              child: Text(_isExpanded ? 'Reset' : 'Animate Box'),
            ),
          ],
        ),
      ),
    );
  }
}
