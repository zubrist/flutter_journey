import 'package:flutter/material.dart';


class HomeScreen2 extends StatelessWidget {
  const HomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
      ),

    body: Row(
      
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          color: Colors.redAccent,
        ),

         Container(
          height: 50,
          width: 50,
          color: Colors.greenAccent,
        ),
         Container(
          height: 150,
          width: 50,
          color: Colors.blueAccent,
        ),
      ],)


    );
  }
}