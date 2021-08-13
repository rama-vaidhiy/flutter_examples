import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        // child: container,//using method 1
        // child: _buildContainer(),//using method 2
        child: const MyContainer(), //using method 3
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {},
      ),
    );
  }
}

//Method 1
// assigning a widget using a constant
//making it final and using it as a variable
final container = Container(
  color: Colors.blue,
  height: 100.0,
  width: 200.0,
  child: Text(
    'Text inside a Container',
    textScaleFactor: 2.0,
  ),
);

//Method 2
// Return by general Widget Name
//or you can return as a Container
Widget _buildContainer() {
  print("Calls _buildContainer");
  return Container(
    color: Colors.blue,
    height: 100.0,
    width: 200.0,
    child: Text(
      'Text inside a Container',
      textScaleFactor: 2.0,
    ),
  );
}

//Method 3
//Create a widget class
class MyContainer extends StatelessWidget {
  //notice the use of const before the constructor
  const MyContainer({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    print('Rebuilds the MyContainer');
    return Container(
      color: Colors.blue,
      height: 100.0,
      width: 200.0,
      child: Text(
        'Text inside a Container',
        textScaleFactor: 2.0,
      ),
    );
  }
}
