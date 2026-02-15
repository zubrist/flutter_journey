// Import Flutter material design package
import 'package:flutter/material.dart';

// Main function – entry point of the Flutter app
void main() => runApp(const PaySlipApp());

// Root widget of the app (stateless)
class PaySlipApp extends StatelessWidget {
  const PaySlipApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payslip Generator',
      home: const PaySlipPage(), // Home screen widget
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.grey[50],
        appBarTheme: const AppBarTheme(centerTitle: true, elevation: 2),
      ),
    );
  }
}

// Main screen – stateful widget because calculations change on input
class PaySlipPage extends StatefulWidget {
  const PaySlipPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PaySlipPageState createState() => _PaySlipPageState();
}

// State class that holds salary input, calculated values and logic
class _PaySlipPageState extends State<PaySlipPage> {
  // Controller to read Basic Salary from TextField
  final TextEditingController _basicController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // Month selection
  final List<String> _months = const [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];
  String _selectedMonth = 'January';

  // Variables to store calculated salary components
  double _hra = 0.0;
  double _da = 0.0;
  double _ma = 300.0;   // Fixed Medical Allowance
  double _gross = 0.0;
  double _it = 0.0;
  double _net = 0.0;

  // String to store error messages for invalid input
  String _errorMsg = '';

  // Function to calculate payslip components
  void _calculatePayslip() {
    if (!_formKey.currentState!.validate()) return;

    double basic = double.parse(_basicController.text.trim());

    // Clear error message if input is valid
    _errorMsg = '';

    // Calculate salary components based on given formulas
    double hra = 0.20 * basic;   // 20% of Basic
    double da = 0.13 * basic;    // 13% of Basic
    double ma = 300.0;           // Fixed Medical Allowance
    double gross = basic + hra + da + ma; // Gross Salary
    double it = 0.05 * basic;    // 5% of Basic as Income Tax
    double net = gross - it;     // Net Salary

    // Update state to show results on UI
    setState(() {
      _hra = hra;
      _da = da;
      _ma = ma;
      _gross = gross;
      _it = it;
      _net = net;
      _errorMsg = '';
    });
  }

  void _reset() {
    setState(() {
      _basicController.clear();
      _hra = 0.0;
      _da = 0.0;
      _ma = 300.0;
      _gross = 0.0;
      _it = 0.0;
      _net = 0.0;
      _errorMsg = '';
      _selectedMonth = _months[0];
    });
  }

  String _fmt(double v) => v.toStringAsFixed(2);

  @override
  Widget build(BuildContext context) {
    // Scaffold provides basic material design visual structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payslip Generator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),   // Outer padding
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Month selector + Basic Salary input
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Month',
                          border: OutlineInputBorder(),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: _selectedMonth,
                            isDense: true,
                            items: _months.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
                            onChanged: (v) => setState(() => _selectedMonth = v!),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _basicController,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        decoration: const InputDecoration(
                          labelText: 'Basic Salary',
                          prefixIcon: Icon(Icons.payments),
                          border: OutlineInputBorder(),
                        ),
                        validator: (v) {
                          if (v == null || v.trim().isEmpty) return 'Enter basic salary';
                          final val = double.tryParse(v.trim());
                          if (val == null || val < 0) return 'Enter a valid positive number';
                          return null;
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Error message for invalid input
                if (_errorMsg.isNotEmpty) Text(_errorMsg, style: const TextStyle(color: Colors.red, fontSize: 14)),

                const SizedBox(height: 12),

                // Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: _calculatePayslip, child: const Text('Generate Payslip')),
                    const SizedBox(width: 16),
                    OutlinedButton(onPressed: _reset, child: const Text('Reset')),
                  ],
                ),

                const SizedBox(height: 20),

                // Payslip Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Payslip for $_selectedMonth', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                        const Divider(),
                        _buildRow('HRA (20% of Basic)', _fmt(_hra)),
                        _buildRow('DA (13% of Basic)', _fmt(_da)),
                        _buildRow('MA (Medical Allowance)', _fmt(_ma)),
                        const SizedBox(height: 8),
                        _buildRow('Gross Salary', _fmt(_gross)),
                        _buildRow('IT (5% of Basic)', _fmt(_it)),
                        const Divider(),
                        _buildRow('Net Salary', _fmt(_net), isEmphasized: true),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isEmphasized = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[800])),
          Text(value, style: TextStyle(fontSize: isEmphasized ? 16 : 14, fontWeight: isEmphasized ? FontWeight.w700 : FontWeight.w500, color: isEmphasized ? Colors.blue : Colors.black)),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _basicController.dispose();
    super.dispose();
  }
}
