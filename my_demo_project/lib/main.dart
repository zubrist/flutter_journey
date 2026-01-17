import 'package:flutter/material.dart';

void main(){
  runApp(
    MaterialApp(
      home: Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(221, 185, 255, 64),
        title: Text("Home Page"),
        centerTitle: true,
      ),  
        body: Center(
          child: Text("Hello World"),
        )
        
        
      )
    )
  );
}

