// Import Flutter material design package
import 'package:flutter/material.dart';

// Main function – entry point of the Flutter application
void main() => runApp(const LoginApp());

// Root widget of the app (stateless)
class LoginApp extends StatelessWidget {
  const LoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Login Validation',
      home: LoginPage(),                 // Home screen is LoginPage
      debugShowCheckedModeBanner: false,
    );
  }
}

// Login screen – stateful widget because data and errors change
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

// State class that holds controllers, errors and validation logic
class _LoginPageState extends State<LoginPage> {

  // Controllers to read text from TextFields
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController    = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Strings to store error messages for each field
  String _usernameError = '';
  String _emailError    = '';
  String _passwordError = '';
  String _successMessage = '';

  // Regular expression for basic email validation
  final RegExp _emailRegex =
      RegExp(r'^[^@]+@[^@]+\.[^@]+');   // simple pattern: text@text.text

  // Regular expressions for password validation
  final RegExp _upperCaseRegex = RegExp(r'[A-Z]');
  final RegExp _lowerCaseRegex = RegExp(r'[a-z]');
  final RegExp _digitRegex     = RegExp(r'\d');
  final RegExp _specialCharRegex = RegExp(r'[!@#\$%^&*(),.?":{}|<>]');

  // Function to validate all fields when Login button is pressed
  void _validateAndLogin() {
    String username = _usernameController.text.trim();
    String email    = _emailController.text.trim();
    String password = _passwordController.text;

    String usernameError = '';
    String emailError    = '';
    String passwordError = '';
    String successMessage = '';

    // Validate username: at least 6 characters
    if (username.isEmpty) {
      usernameError = 'Username is required';
    } else if (username.length < 6) {
      usernameError = 'Username must be at least 6 characters long';
    }

    // Validate email using regex pattern
    if (email.isEmpty) {
      emailError = 'Email is required';
    } else if (!_emailRegex.hasMatch(email)) {
      emailError = 'Please enter a valid email address';
    }

    // Validate password with multiple conditions
    if (password.isEmpty) {
      passwordError = 'Password is required';
    } else {
      if (password.length <= 6) {
        passwordError = 'Password must be more than 6 characters\n';
      }
      if (!_upperCaseRegex.hasMatch(password)) {
        passwordError += '• Must contain at least one uppercase letter\n';
      }
      if (!_lowerCaseRegex.hasMatch(password)) {
        passwordError += '• Must contain at least one lowercase letter\n';
      }
      if (!_digitRegex.hasMatch(password)) {
        passwordError += '• Must contain at least one digit\n';
      }
      if (!_specialCharRegex.hasMatch(password)) {
        passwordError += '• Must contain at least one special character';
      }
    }

    // If no error messages, login is considered successful
    if (usernameError.isEmpty && emailError.isEmpty && passwordError.isEmpty) {
      successMessage = 'Login successful!';
    }

    // Update state to refresh UI with validation messages
    setState(() {
      _usernameError = usernameError;
      _emailError    = emailError;
      _passwordError = passwordError;
      _successMessage = successMessage;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold provides basic visual layout structure
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page with Validation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),   // Outer padding
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Username TextField
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),

              // Username error message
              if (_usernameError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _usernameError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 16),
              // Email TextField
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,  // Email keyboard
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),

              // Email error message
              if (_emailError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _emailError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 16),
              // Password TextField
              TextField(
                controller: _passwordController,
                obscureText: true,                 // Hide password input
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),

              // Password error message
              if (_passwordError.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Text(
                    _passwordError,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),

              const SizedBox(height: 24),
              // Login button using ElevatedButton
              ElevatedButton(
                onPressed: _validateAndLogin,    // Call validation function
                child: const Text('LOGIN'),
              ),

              const SizedBox(height: 16),

              // Success message (shown when all validations pass)
              if (_successMessage.isNotEmpty)
                Text(
                  _successMessage,
                  style: const TextStyle(color: Colors.green, fontSize: 16),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
