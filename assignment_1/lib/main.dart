// Import Flutter material design library
import 'package:flutter/material.dart';

// Import math library for using pow() function
import 'dart:math';

// Main function – entry point of the Flutter app
void main() => runApp(const CalculatorApp());

// Root widget of the application (stateless)
class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Simple Calculator',   // App title shown in task switcher
      home: Calculator(),           // Sets Calculator as the home screen
      debugShowCheckedModeBanner: true,
    );
  }
}

// Main screen of the app – stateful because result and errors change
class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _CalculatorState createState() => _CalculatorState();
}

// State class that holds UI state and calculator logic
class _CalculatorState extends State<Calculator> {

  // Controllers to read input from TextFields
  final TextEditingController _num1Controller = TextEditingController();
  final TextEditingController _num2Controller = TextEditingController();

  // Variables to store result and error messages
  String _result = '';
  String errmsg = '';

  // Common function to validate and parse both inputs
  // Returns null if any error occurs and sets errmsg accordingly
  List<double>? _parseInputs() {
    double? num1 = double.tryParse(_num1Controller.text);
    double? num2 = double.tryParse(_num2Controller.text);

    if (num1 == null || num2 == null) {
      setState(() {
        errmsg = 'Please enter valid numeric values in both fields';
        _result = '';
      });
      return null;  // indicate failure
    }
    // Clear previous error if inputs are valid
    setState(() {
      errmsg = '';
    });
    return [num1, num2];
  }

  // Function to perform addition
  void add() {
    final values = _parseInputs();
    if (values == null) return;          // stop if invalid input

    double res = values[0] + values[1];
    setState(() {
      _result = 'Sum is $res';
    });
  }

  // Function to perform subtraction
  void sub() {
    final values = _parseInputs();
    if (values == null) return;

    double res = values[0] - values[1];
    setState(() {
      _result = 'Difference is $res';
    });
  }

  // Function to perform multiplication
  void multiply() {
    final values = _parseInputs();
    if (values == null) return;

    double res = values[0] * values[1];
    // Result formatted up to 2 decimal places
    setState(() {
      _result = 'Product is ${res.toStringAsFixed(2)}';
    });
  }

  // Function to perform division with zero‑denominator check
  void divide() {
    final values = _parseInputs();
    if (values == null) return;

    double num1 = values[0];
    double num2 = values[1];

    // Check for division by zero
    if (num2 == 0) {
      setState(() {
        errmsg = 'Division by zero is not allowed';
        _result = '';
      });
      return;
    }

    double res = num1 / num2;
    setState(() {
      _result = 'Quotient is ${res.toStringAsFixed(2)}';
      errmsg = '';
    });
  }

  // Function to perform power operation (num1 ^ num2)
  void power() {
    final values = _parseInputs();
    if (values == null) return;

    double base = values[0];
    double exponent = values[1];

    num res = pow(base, exponent);   // pow returns num type
    setState(() {
      _result = 'Result is ${res.toStringAsFixed(2)}';
      errmsg = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides basic visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('Simple Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),     // Outer padding
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // First input field
            TextField(
              controller: _num1Controller,
              keyboardType: TextInputType.number, // Show numeric keyboard
              decoration: const InputDecoration(
                labelText: 'Enter first number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            // Second input field
            TextField(
              controller: _num2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter second number',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            // Text widget to display result
            Text(
              _result,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.blue,
              ),
            ),

            // Text widget to display error messages
            Text(
              errmsg,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),

            const SizedBox(height: 20),

            // Row for operation buttons using RaisedButton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // ADD button
                ElevatedButton(
                  onPressed: add,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('ADD'),
                ),

                // SUBTRACT button
                ElevatedButton(
                  onPressed: sub,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('SUBTRACT'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // MULTIPLY button
                ElevatedButton(
                  onPressed: multiply,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('MULTIPLY'),
                ),

                // DIVISION button
                ElevatedButton(
                  onPressed: divide,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('DIVISION'),
                ),
              ],
            ),

            const SizedBox(height: 10),

            // POWER button in a separate row
            Center(
              child: ElevatedButton(
                onPressed: power,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('POWER'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
