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
        debugShowCheckedModeBanner: false,
        home: HomeScreen2()
      );
  }
  
}
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
              backgroundColor: const Color.fromARGB(221, 7, 166, 20),
              title: Text("Landing Page"),
    )
    );
    
  }
}


class HomeScreen2 extends StatefulWidget {
  const HomeScreen2({super.key});

  @override
  State<HomeScreen2> createState() => _HomeScreen2State();
}

class _HomeScreen2State extends State<HomeScreen2> {
  String title ="Stateful Home";

  String btnTxt = "Click ME";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Colors.blueGrey,
      ),

      body: ElevatedButton(
        onPressed:(){
          setState(() {
            title = "Stateless Widget";
            print(title);
            btnTxt = "dont click me";
          });

                  
      

        },
        child: Text(btnTxt)),  
    );
  }
}