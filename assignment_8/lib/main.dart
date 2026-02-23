import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Biodata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
      ),
      home: const BiodataScreen(),
    );
  }
}

class BiodataScreen extends StatelessWidget {
  const BiodataScreen({super.key});

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  TableRow _tableHeader(List<String> titles) {
    return TableRow(
      decoration: BoxDecoration(color: Colors.grey.shade300),
      children: titles
          .map(
            (text) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                text,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          )
          .toList(),
    );
  }

  TableRow _tableRow(List<String> values) {
    return TableRow(
      children: values
          .map(
            (text) => Padding(
              padding: const EdgeInsets.all(8),
              child: Text(text),
            ),
          )
          .toList(),
    );
  }

  Widget _infoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label:',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Biodata Profile'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 36,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Sakshi Roy',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text('123, Park Lane, Siliguri'),
                        Text('Email: sakshi.roy@email.com'),
                        Text('Contact: +91 98765 43210'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Personal Information'),
                    _infoRow('Date of Birth', '08 August 2003'),
                    _infoRow('Gender', 'Female'),
                    _infoRow('Nationality', 'Indian'),
                    _infoRow('Marital Status', 'Single'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Educational Qualification'),
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.2),
                        3: FlexColumnWidth(1.2),
                      },
                      children: [
                        _tableHeader([
                          'Exam',
                          'Board',
                          'Year',
                          'Percentage',
                        ]),
                        _tableRow(['Madhyamik', 'WBBSE', '2020', '87%']),
                        _tableRow(['Higher Secondary', 'WBCHSE', '2022', '83%']),
                        _tableRow(['Bachelor of Arts', 'University of North Bengal', '2025', 'In Progress']),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Professional Qualification / Internship'),
                    Table(
                      border: TableBorder.all(color: Colors.grey.shade300),
                      columnWidths: const {
                        0: FlexColumnWidth(2),
                        1: FlexColumnWidth(1.5),
                        2: FlexColumnWidth(1.2),
                      },
                      children: [
                        _tableHeader([
                          'Institution',
                          'Course',
                          'Duration',
                        ]),
                        _tableRow(['Akash Institute', 'UI/UX Design', '2 Months']),
                        _tableRow(['DreamWorks Studio', 'Digital Marketing', '1 Month']),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _sectionTitle('Extra Curricular Activities'),
                    const Text('• Member of the Western Dance Club at college'),
                    const Text('• Volunteer for community library drives'),
                    const Text('• Participated in inter-school debate competitions'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 1,
                    color: Colors.grey.shade400,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60,
                  child: Image.asset(
                    'assets/signature.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 4),
                const Text('Signature'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}