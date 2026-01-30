import 'package:flutter/material.dart';


//  Display ' Hello! Flutter' at the homepage and on click of a btn 
// change the text to  'Hello World'
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),

    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String msg = "Hello! Flutter";

  void changeTxt(){
    setState(() {
      msg = "Hello! World  Hello! Flutter Hello! Flutter";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("basic fltter App"),
        backgroundColor: Colors.cyan[300],
      ),
      body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              msg,
              // textAlign: TextAlign.justify,
              textDirection: TextDirection.ltr,
              style: const TextStyle(fontSize:40,
                                fontWeight:FontWeight.bold,
                                fontStyle: FontStyle.italic,
                                color : Colors.redAccent,
                                letterSpacing: 2.5,
                                height: 1.5,
                                // decoration: TextDecoration.underline,
                                // decorationColor: Colors.amberAccent,
                                // decorationThickness: 2.0,
                                // fontFamily: 'family1'
                                // shadows: [
                                //   Shadow(
                                //     color: Colors.black,
                                //     blurRadius: 20,
                                //     offset: Offset(20, 25)
                                //   ),
                                //    Shadow(
                                //     color: Colors.greenAccent,
                                //     blurRadius: 10,
                                //     offset: Offset(30, 25)
                                //   ),
                                // ]
                                backgroundColor: Colors.yellowAccent

                                ),

                                
                                
              ),

          const SizedBox(height: 20), 

          ElevatedButton(
            onPressed:changeTxt , 
          
          child: Text("Change msg"),
                  )   
          ]
        )

      ),
    );
  }
}