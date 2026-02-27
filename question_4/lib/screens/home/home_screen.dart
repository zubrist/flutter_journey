import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  @override
  // Dispose of the TextEditingControllers to free up resources when the widget is destroyed
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  /// Validates and checks the eligibility of a user based on their name and age inputs.
  ///
  /// This function performs the following operations:
  /// - Retrieves and trims the name from the [_nameController] text field
  /// - Attempts to parse the age from the [_ageController] text field as an integer
  /// - Validates that both the name is not empty and age is a valid number
  /// - Displays a red error SnackBar message if validation fails
  /// - Returns early if validation fails, preventing further processing
  ///
  /// The function expects [_nameController] and [_ageController] to be initialized
  /// TextEditingControllers. A valid SnackBar will be shown with the message
  /// "Please enter valid Name and Age" if either the name field is empty or
  /// the age cannot be parsed as an integer.
  void _checkEligibility() {
    final String name = _nameController.text.trim();
    final int? age = int.tryParse(_ageController.text.trim());

    if (name.isEmpty || age == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter valid Name and Age"),
          backgroundColor: Colors.red,

        ),
      );
      
      return;
    }

    if (age < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter a valid (non-negative) age"),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final String message = age >= 18
        ? "$name is eligible to vote"
        : "$name is not eligible to vote";

    // age=>18 ? elugible : not eligible

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: age >= 18 ? Colors.green : Colors.orange,
      ),
    );
  }

  void _clearFields() {
    _nameController.clear();
    _ageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Voter Eligibility App"),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: "Name",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                prefixIcon: const Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                prefixIcon: const Icon(Icons.numbers),
              ),
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: _checkEligibility,
                  child: const Text("Check"),
                ),
                ElevatedButton(
                  onPressed: _clearFields,
                  // style: ElevatedButton.styleFrom(
                  //   backgroundColor: Colors.grey,
                  // ),
                  child: const Text("Clear"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}