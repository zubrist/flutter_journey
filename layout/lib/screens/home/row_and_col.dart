import 'package:flutter/material.dart';


class RowsAndCols extends StatelessWidget {
  const RowsAndCols({super.key});

  @override
  Widget build(BuildContext context) {
    final int reviews = 150; // !!! number of reviews

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Rows & Columns'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            // left panel : title ...
            SizedBox(
              width: 160, // slightly wider to avoid cramped layout
              child: Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title (actual) and description
                    const Text(
                      'Forest Tent',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 6),

                    const Text(
                      'Cozy 2‑person tent with waterproof coating and breathable mesh.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // Rating stars (smaller) with reviews underneath
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: List.generate(
                            5,
                            (i) => const Padding(
                              padding: EdgeInsets.only(right: 1.5),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 12,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 6),

                        Text(
                          '$reviews reviews',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    // Button !!!
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {}, // !!!
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                        ),
                        child: const Text('Book Now'), // updated label
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(width: 12),

            // right panel / image placeholder - takes remaining space
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade900,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: Colors.greenAccent.shade400,
                    width: 2,
                  ),
                ),
                child: const Center(
                  child: Text(
                    'Image',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 28,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
