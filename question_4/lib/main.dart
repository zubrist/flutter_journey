/* Develop a Flutter app using Dart programming to create a 
form with multiple input fields (name, Age) 
and calculate he or she is eligible for voter or not. 
(If Age >=18 then display "Eligible for vote" otherwise show 
"not Eligible for vote") 
*/ 
import 'package:flutter/material.dart';
import 'package:question_4/screens/home/home_screen.dart';

void main() {
  runApp(const VoterAge());
}

class VoterAge extends StatelessWidget {
  const VoterAge({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}