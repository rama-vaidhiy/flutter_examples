import 'package:flutter/material.dart';

void main() {
  runApp(MyFirstApp());
}

class MyFirstApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Title of the App'),
        ),
        body: Center(
          //adds the child element to the center of the display area
          child: Text('Body of the App'),
        ),
      ),
      debugShowCheckedModeBanner: false, //removes the debug message at the top
    );
  }
}
