import 'package:flutter/material.dart';

void main()
{
 runApp(const MyApp());

}
// this is our first widget called MyApp
class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
              backgroundColor: const Color.fromARGB(221, 255, 179, 64),
              title: Text("Landing Page"),
        
      ),
      ),
      );
  }
  
}