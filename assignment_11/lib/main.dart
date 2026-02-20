
import 'package:flutter/material.dart';


void main() => runApp(const TourApp());

// Images are stored under lib/assets/tourist_places/
const List<Map<String, String>> _places = [
  {'name': 'Andaman',  'img': 'lib/assets/tourist_places/pexels-vincent-gerbouin-445991-1179156.jpg'},
  {'name': 'Mughal Architecture', 'img': 'lib/assets/tourist_places/pexels-timfuzail-2261660.jpg'},
  {'name': 'Historic Places ', 'img': 'lib/assets/tourist_places/pexels-shalenderkumar-4143959.jpg'},
  {'name': 'Jaipur',   'img': 'lib/assets/tourist_places/pexels-sbsoneji-3581369.jpg'},
  {'name': 'Sea ',    'img': 'lib/assets/tourist_places/pexels-pixabay-163872.jpg'},
  {'name': 'Forest Trail',    'img': 'lib/assets/tourist_places/pexels-ollivves-1122410.jpg'},
  {'name': 'Waterfall',     'img': 'lib/assets/tourist_places/pexels-ollivves-1020016.jpg'},
  {'name': 'Sun temple',   'img': 'lib/assets/tourist_places/pexels-navneet-shanu-202773-672630.jpg'},
  {'name': 'Taj Mahal',    'img': 'lib/assets/tourist_places/pexels-kirandeepsingh-7800311.jpg'},
  {'name': 'Scenic Lake',       'img': 'lib/assets/tourist_places/pexels-jaime-reimer-1376930-2662116.jpg'},
  {'name': 'Maldives',     'img': 'lib/assets/tourist_places/pexels-elena-zhuravleva-647531-1457812.jpg'},
  {'name': 'Alpine Meadow',   'img': 'lib/assets/tourist_places/pexels-eberhardgross-443446.jpg'},
  {'name': 'Snowy Peaks',    'img': 'lib/assets/tourist_places/pexels-eberhardgross-1366907.jpg'},
  {'name': 'Sunset Beach',    'img': 'lib/assets/tourist_places/pexels-asadphoto-1450360.jpg'},
];


class TourApp extends StatelessWidget {
  const TourApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XYZ Tour & Travels',
      debugShowCheckedModeBanner: false, // hide the debug ribbon
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const HomePage(), // start at the home screen
    );
  }
}


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

     
      appBar: AppBar(
        title: const Text(
          'XYZ Tour & Travels',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.1),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // ── Side Drawer ───────
      drawer: Drawer(
        child: Column(
          children: [
            // Drawer header 
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.teal),
              child: Row(
                children: [
                  // Travel icon 
                  Icon(Icons.travel_explore, color: Colors.white, size: 36),
                  SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tourist-spots',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'XYZ Tour & Travels',
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Drawer menu items 
            ListTile(
              leading: const Icon(Icons.home_outlined, color: Colors.teal),
              title: const Text('Home'),
              onTap: () => Navigator.pop(context), 
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: Colors.teal),
              title: const Text('Tourist Places Gallery'),
              // Navigate to the gallery page 
              onTap: () {
                Navigator.pop(context); 
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryPage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.teal),
              title: const Text('About Us'),
              onTap: () => Navigator.pop(context),
            ),

            const Divider(),

            ListTile(
              leading: const Icon(Icons.contact_mail_outlined, color: Colors.teal),
              title: const Text('Contact'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),

      
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.travel_explore,
                  size: 90, color: Colors.teal.shade300),
              const SizedBox(height: 20),
              const Text(
                'Welcome to XYZ Tour & Travels!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Discover breathtaking destinations around the world.\n'
                'Tap the button below or use the menu to explore our Tourist-spots gallery.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54, height: 1.6),
              ),
              const SizedBox(height: 30),

              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 14),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
                icon: const Icon(Icons.photo_album_outlined),
                label: const Text('Explore Places',
                    style: TextStyle(fontSize: 16)),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const GalleryPage()),
                ),
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.photo_library),
        label: const Text('Gallery'),
        tooltip: 'View Tourist Places',
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const GalleryPage()),
        ),
      ),
    );
  }
}

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar for the gallery screen
      appBar: AppBar(
        title: const Text('Tourist Places',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        elevation: 4,
      ),

      // GridView displays all images in a 2-column layout
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          itemCount: _places.length, 
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,      
            crossAxisSpacing: 10,   
            mainAxisSpacing: 10,    
            childAspectRatio: 0.85, 
          ),
          itemBuilder: (context, index) {
            final place = _places[index]; 
            return _PlaceCard(
              name: place['name']!,
              imagePath: place['img']!,
            );
          },
        ),
      ),
    );
  }
}


class _PlaceCard extends StatelessWidget {
  final String name;       
  final String imagePath; 

  const _PlaceCard({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) =>
              _DetailPage(name: name, imagePath: imagePath),
        ),
      ),
      child: Card(
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover, 
              ),
            ),
            Container(
              color: Colors.teal,
              padding: const EdgeInsets.symmetric(
                  vertical: 8, horizontal: 8),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DetailPage extends StatelessWidget {
  final String name;      
  final String imagePath; 

  const _DetailPage({required this.name, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name,
            style: const TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: InteractiveViewer(
        minScale: 0.8,
        maxScale: 4.0,
        child: Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.contain, 
          ),
        ),
      ),
    );
  }
}
