import 'package:flutter/material.dart';
import 'package:layout/screens/home/home_screen.dart';
import 'package:layout/screens/home/home_screen2.dart';
import 'package:layout/screens/home/row_and_col.dart';

void main(){
  runApp( const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: RowsAndCols(),
      debugShowCheckedModeBanner:false,
    );
  }
}