import 'package:flutter/material.dart';
import 'calculator_home.dart';

void main() {
  runApp(MyApp());
}

//Create a MyApp Stateless Widget and use this
//as the holder class for your Material Design
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        backgroundColor: Colors.black12,
      ),
      home: CalculatorHomePage(title: 'Flutter Calculator'),
    );
  }
}
