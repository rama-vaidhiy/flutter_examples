import 'package:flutter/material.dart';

import 'calculations.dart';

//The home page for the actual calculator elements to be built
//it is a stateful widget as we need to store the state of the
//input and produce an output
class CalculatorHomePage extends StatefulWidget {
  final String title;

  const CalculatorHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _str = '0'; //initial calculator screen value
  Calculations _calculations = Calculations();
  Widget _getCalculatorScreen() {
    return Expanded(
      flex: 2,
      child: Card(
        color: Colors.lightBlue[50],
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Text(
            _str,
            textScaleFactor: 2.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //add a calculator screen here,
          _getCalculatorScreen(),
          //row 1,
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //deleteAll Button
                Expanded(
                  flex: 3,
                  child: TextButton(
                    onPressed: deleteAll,
                    style: TextButton.styleFrom(
                      primary: Colors.blueAccent,
                      backgroundColor: Colors.grey,
                    ),
                    child: Text(
                      'C',
                      textScaleFactor: 2.0,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                //deleteOne Button
                Expanded(
                  flex: 1,
                  child: TextButton(
                    onPressed: deleteOne,
                    style: TextButton.styleFrom(
                      primary: Colors.blueAccent,
                      backgroundColor: Colors.blueGrey,
                    ),
                    child: Text(
                      '<-',
                      textScaleFactor: 2.0,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          //row 2,
          Expanded(
            flex: 4,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //column 1
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //row 1
                      ExpandedRow(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _createTextButtonForNumbers('7'),
                          _createTextButtonForNumbers('8'),
                          _createTextButtonForNumbers('9'),
                        ],
                      ),
                      //row 2
                      ExpandedRow(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _createTextButtonForNumbers('4'),
                          _createTextButtonForNumbers('5'),
                          _createTextButtonForNumbers('6'),
                        ],
                      ),
                      //row 3
                      ExpandedRow(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _createTextButtonForNumbers('1'),
                          _createTextButtonForNumbers('2'),
                          _createTextButtonForNumbers('3'),
                        ],
                      ),
                      //row 4
                      ExpandedRow(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _createTextButtonForNumbers('0'),
                          _createTextButtonForNumbers('.'),
                          //changed it for = as it calls a different function
                          Expanded(
                            child: TextButton.icon(
                              icon: Icon(Icons.view_agenda),
                              onPressed: () {
                                getResult();
                              },
                              label: Text(''),
                            ),
                          ),
                          // ExpandedButton(
                          //   onPressed: () {
                          //     getResult();
                          //   },
                          //   color: Colors.blueAccent,
                          //   child: Text(
                          //     '=',
                          //     textScaleFactor: 2.0,
                          //     style: TextStyle(color: Colors.white),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),

                //column 2
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //divide
                      //you can change this to IconButton
                      //and add images from the assets if you wish to
                      ExpandedButton(
                        onPressed: () {
                          add('/');
                        },
                        color: Colors.white,
                        child: Text(
                          '/',
                          textScaleFactor: 2.0,
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                      //multiply
                      Expanded(
                        child: TextButton.icon(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            add('x');
                          },
                          label: Text(''),
                        ),
                      ),
                      // ExpandedButton(
                      //   onPressed: () {
                      //     add('x');
                      //   },
                      //   color: Colors.blueAccent,
                      //   child: Text(
                      //     'x',
                      //     textScaleFactor: 2.0,
                      //     style: TextStyle(color: Colors.white),
                      //   ),
                      // ),
                      //subtract
                      Expanded(
                        child: TextButton.icon(
                          icon: Icon(Icons.remove),
                          onPressed: () {
                            add('-');
                          },
                          label: Text(''),
                        ),
                        // onPressed: () {
                        //   add('-');
                        // },
                        // color: Colors.blueAccent,
                        // child: Text(
                        //   '-',
                        //   textScaleFactor: 2.0,
                        //   style: TextStyle(color: Colors.white),
                        // ),
                      ),
                      //add
                      // ExpandedButton(
                      //   onPressed: () {
                      //     add('+');
                      //   },
                      //   color: Colors.blueAccent,
                      //  child:
                      Expanded(
                        child: TextButton.icon(
                          icon: Icon(Icons.add),
                          onPressed: () {
                            add('+');
                          },
                          label: Text(''),
                        ),
                      ),
                      //),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //get the text buttons for the calculator
  ExpandedButton _createTextButtonForNumbers(String a) {
    return ExpandedButton(
      onPressed: () {
        add(a);
      },
      color: Colors.black87,
      child: Text(
        a,
        textScaleFactor: 2.0,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  void add(String a) {
    setState(() {
      _calculations.add(a);
      _str = _calculations.getString();
    });
  }

  void deleteAll() {
    setState(() {
      _calculations.deleteAll();
      _str = _calculations.getString();
    });
  }

  void deleteOne() {
    setState(() {
      _calculations.deleteOne();
      _str = _calculations.getString();
    });
  }

  void getResult() {
    setState(() {
      try {
        _str = _calculations.getResult().toString();
      } on DivideByZeroException {
        _str = 'Divide by Zero not allowed';
      } finally {
        _calculations = Calculations();
      }
    });
    //  _calculations = Calculations();
  }
}

class ExpandedButton extends StatelessWidget {
  final Widget child;
  final VoidCallback onPressed;
  final Color color;
  const ExpandedButton(
      {required this.child, required this.onPressed, required this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: TextButton(
        onPressed: this.onPressed,
        child: this.child,
        style: TextButton.styleFrom(
          primary: Colors.blueAccent,
          backgroundColor: this.color,
        ),
      ),
    );
  }
}

class ExpandedRow extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  const ExpandedRow({required this.children, required this.crossAxisAlignment});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Row(
        crossAxisAlignment: this.crossAxisAlignment,
        children: this.children,
      ),
    );
  }
}
