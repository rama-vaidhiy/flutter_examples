import 'package:flutter/material.dart';

///Create a Counter Text widget by extending a StatelessWidget
///This consists of just the Text widget and a count value
class CounterText extends StatelessWidget {
  CounterText(this.count);
  final int count;
  @override
  Widget build(BuildContext context) {
    return Text(
      'You have pressed the button $count times',
      style: Theme.of(context).textTheme.headline4,
    );
  }
}

///Create a button widget by extending the StatelessWidget
///and this has a Text which indicates what the button does
///and a VoidCallback which manages the actions when the button is pressed
class CounterButton extends StatelessWidget {
  CounterButton(this.onPressed);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text('+'),
      onPressed: onPressed,
    );
  }
}

///The actual UI which is a StatefulWidget will now use the CounterText and the
///CounterButton in it thereby storing the state in its relevant widget subtree
class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int count = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Using Widgets with Data')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: <Widget>[
              CounterButton(() {
                setState(() {
                  count++;
                });
              }),
              CounterText(count),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      title: 'Flutter State Management Demo using Stateful Widget',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(headline4: TextStyle(color: Colors.blue)),
      ),
      home: Counter(),
    ),
  );
}
