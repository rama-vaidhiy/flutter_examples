import 'package:flutter/material.dart';
import 'package:sample_stateful_app/MyStatefulApp.dart';

void main() {
  runApp(MyStatelessApp());
}

//Stateless Widget to start the application
class MyStatelessApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //the MyStatefulApp class is defined in a separate file and is imported.
      home: MyStatefulApp(),
    );
  }
}
