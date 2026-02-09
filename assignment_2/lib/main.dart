// Import Flutter material design package
import 'package:flutter/material.dart';

// Main function – entry point of the Flutter application
void main() => runApp(const TemperatureConverterApp());

// Root widget of the app (stateless)
class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Temperature Converter',     // App title
      home: TemperatureConverter(),       // Home screen widget
      debugShowCheckedModeBanner: false,
    );
  }
}

// Main screen – stateful widget because data and result change
class TemperatureConverter extends StatefulWidget {
  const TemperatureConverter({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

// State class that holds all UI state and conversion logic
class _TemperatureConverterState extends State<TemperatureConverter> {

  // Controller to read value from TextField
  final TextEditingController _tempController = TextEditingController();

  // Available temperature units
  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];

  // Currently selected "from" and "to" units
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';

  // Strings to display result and error message
  String _result = '';
  String _errorMsg = '';

  // Helper function: convert given value from any unit to Celsius
  double _toCelsius(double value, String unit) {
    switch (unit) {
      case 'Fahrenheit':
        return (value - 32) * 5 / 9;
      case 'Kelvin':
        return value - 273.15;
      case 'Celsius':
      default:
        return value;
    }
  }

  // Helper function: convert value (in Celsius) to target unit
  double _fromCelsius(double celsiusValue, String unit) {
    switch (unit) {
      case 'Fahrenheit':
        return celsiusValue * 9 / 5 + 32;
      case 'Kelvin':
        return celsiusValue + 273.15;
      case 'Celsius':
      default:
        return celsiusValue;
    }
  }

  // Function to handle conversion button press
  void _convertTemperature() {
    // Try to parse the input text as double
    double? inputValue = double.tryParse(_tempController.text);

    if (inputValue == null) {
      // Non-numeric or empty input
      setState(() {
        _errorMsg = 'Please enter a valid numeric temperature value';
        _result = '';
      });
      return;
    }

    // Clear previous error if input is valid
    setState(() {
      _errorMsg = '';
    });

    // Step 1: convert input value to Celsius
    double valueInCelsius = _toCelsius(inputValue, _fromUnit);

    // Step 2: convert from Celsius to desired output unit
    double convertedValue = _fromCelsius(valueInCelsius, _toUnit);

    // Update result string with formatted value
    setState(() {
      _result =
          '${_tempController.text} $_fromUnit = ${convertedValue.toStringAsFixed(2)} $_toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides the basic visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),  // Outer padding for the screen
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Input TextField for temperature value
            TextField(
              controller: _tempController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter temperature value',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            // Row for selecting "From" and "To" units
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Dropdown for input unit (From)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('From Unit'),
                      DropdownButton<String>(
                        value: _fromUnit,
                        isExpanded: true,
                        items: _units.map((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _fromUnit = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 16),

                // Dropdown for output unit (To)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('To Unit'),
                      DropdownButton<String>(
                        value: _toUnit,
                        isExpanded: true,
                        items: _units.map((String unit) {
                          return DropdownMenuItem<String>(
                            value: unit,
                            child: Text(unit),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _toUnit = newValue!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Button to perform conversion
            ElevatedButton(
              onPressed: _convertTemperature,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('CONVERT'),
            ),

            const SizedBox(height: 16),

            // Text widget to display converted result
            Text(
              _result,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.green,
              ),
            ),

            // Text widget to display error messages
            Text(
              _errorMsg,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
