import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyStatefulApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyState();
  }
}

//in Dart, if we wanted to make something private
//we use _ before their names which makes it a private class
//or a private attribute
class _MyState extends State<MyStatefulApp> {
  int _counter = 0;

  //private method that increments the counter attribute
  void _incrementCounter() {
    //calling the addition inside a setState method to ensure
    //that the widget that contains this instance will be marked as
    //dirty and hence will rebuilt in the UI rendering engine.
    //if the counter is incremented outside of the setState() function
    //then the UI will not get updated.
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Title of the App'),
      ),
      body: Center(
        child: Text(
          'Body of the App $_counter',
          style: TextStyle(fontSize: 25),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        //option C: a cleaner way is to write a private function
        //which does the same thing as the anonymous function
        //and call it here. See how it is not being called as
        // _incrementCounter(). This is a JS way of calling functions
        onPressed: _incrementCounter,
        //option B: using anonymous function for onPressed event is given
        //below, this will happily update the counter and will also update
        //the UI.
        // onPressed: () {
        //   setState(() {
        //     _counter++;
        //   });
        // },
        //option A: just increment the counter on an onPressed event:
        //increments the counter in the system but doesn't update the UI. why?
        //because the setState isn't called to set the flag to dirty for the
        //UI to re-render
        //onPressed:() => {_counter++}
      ),
    );
  }
}
