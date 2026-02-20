import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 243, 203, 60),
        title: Text("Registration form"),
      ),
      body: Wrap(
        children: [
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "username",
              hintText: "Enter your name",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.person),
              ),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Email no.",
              hintText: "Enter your email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.email)),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Enter your password",
              hintText: "password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.lock_outline)),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Confirm your password",
              hintText: "Confirm password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.phone_android)),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Phone",
              hintText: "Enter your phone number",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "DOB",
              hintText: "Enter your date of birth",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              prefixIcon: IconButton(
                onPressed: () {},
                icon: Icon(Icons.calendar_month),
              ),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Image",
              hintText: "Attach your image",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.image)),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "Madhyamik Result",
              hintText: "Attach your madhyamik result",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.file_upload)),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 20),
          TextField(
            decoration: InputDecoration(
              labelText: "High-Secondary Result",
              hintText: "Attach your high-secondary result",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              prefixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.file_upload)),
              suffixIcon: IconButton(onPressed: () {}, icon: Icon(Icons.close)),
            ),
          ),
          SizedBox(height: 40),
          ElevatedButton(onPressed: () {}, child: Text("Login")),
        ],
      ),
    );
  }
}
