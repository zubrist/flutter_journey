// Import Flutter material design package
import 'package:flutter/material.dart';

// ─── B&W palette 
const _black  = Color(0xFF000000);
const _dark   = Color(0xFF212121);
const _mid    = Color(0xFF616161);
const _light  = Color(0xFFF5F5F5);
const _white  = Color(0xFFFFFFFF);

void main() => runApp(const ProfileApp());

class ProfileApp extends StatelessWidget {
  const ProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Profile',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: _black,
          onPrimary: _white,
          surface: _white,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: _white,
        cardTheme: CardTheme(
          color: _white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
            side: const BorderSide(color: _black, width: 2),
          ),
        ),
      ),
      home: const ProfilePage(),
    );
  }
}

// ─── Profile page ─────────────────────────────────────────────────────────────
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: _black,
        elevation: 0,
        title: const Text(
          'My Profile',
          style: TextStyle(
            color: _white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
            letterSpacing: 1.4,
          ),
        ),
      ),

      
      body: Container(
        color: _white,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            children: [
              // ── Hero card (banner + avatar + name) ───────────────────────────
              _HeroCard(),

              const SizedBox(height: 16),

              // ── Bio card ─────────────────────────────────────────────────────
              const _SectionCard(
                icon: Icons.person_outline,
                title: 'Bio',
                iconColor: _black,
                child: Text(
                  'I am a Flutter enthusiast who enjoys building cross-platform '
                  'mobile applications. I love learning new technologies and '
                  'creating clean, user-friendly interfaces.',
                  textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 15, height: 1.6, color: _dark),
                ),
              ),

              const SizedBox(height: 16),

              // ── Projects card ─────────────────────────────────────────────────
              const _SectionCard(
                icon: Icons.code,
                title: 'Projects',
                iconColor: _black,
                child: Column(
                  children: [
                    _ProjectTile(
                      title: 'Age Calculator',
                      desc: 'Calculates age from date of birth with a clean Material UI.',
                      icon: Icons.cake_outlined,
                    ),
                    SizedBox(height: 10),
                    _ProjectTile(
                      title: 'Payslip Generator',
                      desc: 'Generates monthly payslips with deductions and formatted output.',
                      icon: Icons.receipt_long_outlined,
                    ),
                    SizedBox(height: 10),
                    _ProjectTile(
                      title: 'Temperature Converter',
                      desc: 'Converts between Celsius, Fahrenheit and Kelvin instantly.',
                      icon: Icons.thermostat_outlined,
                    ),
                    SizedBox(height: 10),
                    _ProjectTile(
                      title: 'Audio Player',
                      desc: 'Cross-platform audio player with web-safe fallback support.',
                      icon: Icons.music_note_outlined,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Hero card ────────────────────────────────────────────────────────────────
class _HeroCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          // Solid black banner
          Container(
            height: 90,
            decoration: const BoxDecoration(
              color: _black,
              borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
            ),
          ),

          // Avatar overlapping the banner
          Transform.translate(
            offset: const Offset(0, -48),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: _black, width: 3),
                color: _white,
              ),
              child: const CircleAvatar(
                radius: 48,
                backgroundImage: AssetImage('assets/images/images.png'),
                backgroundColor: _light,
              ),
            ),
          ),

          // Name + role badge
          Transform.translate(
            offset: const Offset(0, -36),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  const Text(
                    'Upasana Basak',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: _dark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 4),
                    decoration: BoxDecoration(
                      color: _black,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Flutter Developer',
                      style: TextStyle(
                          color: _white,
                          fontSize: 13,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}


class _SectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Widget child;

  const _SectionCard({
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section header
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: _light,
                    border: Border.all(color: _black, width: 1.5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 20),
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: _dark,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            child,
          ],
        ),
      ),
    );
  }
}

// ─── Project tile ─────
class _ProjectTile extends StatelessWidget {
  final String title;
  final String desc;
  final IconData icon;

  const _ProjectTile({
    required this.title,
    required this.desc,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _white,
        border: Border.all(color: _black, width: 1.8),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: _black,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: _white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: _dark)),
                const SizedBox(height: 3),
                Text(desc,
                    style: const TextStyle(
                        fontSize: 12, color: _mid)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
