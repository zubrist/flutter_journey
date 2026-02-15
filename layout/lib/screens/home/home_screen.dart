import 'package:flutter/material.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[400],
        title: const Text("Layout", 
                    style: const TextStyle(
                       fontWeight: FontWeight.bold,
                       fontSize: 40,
                       )),
      ),
      body: Column(
        //spacing: 20,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,  


        children: [
          //continer 0
          Container(
            width: double.infinity,
          ),


          // container 1
          Container(
            height: 100,
            width: 100,
            color: Colors.lime,

          ),
          // container 2
          Container(
            height: 100,
            width: 100,
            color: Colors.redAccent,

          ),
          // Container 3
          Container(
            height: 100,
            width: 100,
            color: Colors.blueAccent,

          ),

          const Text("This is a sample text"),

          ElevatedButton(
            onPressed: (){},
             child: const Text("Click me"),
          )
        ],

      )



    );
  }
}