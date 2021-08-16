import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//NOTE: For this example to work, you need to add
//shared_preferences: ^2.0.6 in the dependencies in pubspec.yaml file

class SimpleStatefulHome extends StatefulWidget {
  const SimpleStatefulHome({Key? key}) : super(key: key);

  @override
  _SimpleStatefulHomeState createState() => _SimpleStatefulHomeState();
}

class _SimpleStatefulHomeState extends State<SimpleStatefulHome> {
  int _counter = 0;
  //the ? after the variable is added for null safety
  //documentation: https://dart.dev/null-safety#null-safety-principles
  SharedPreferences? pref;

  @override
  void initState() {
    //remember initState is the first call that happens when the
    //State of a Widget is being built.
    //so if you want to initialize any data that you need on the screen
    //you need to set it here.
    //This is applicable only for the stateful widgets.
    super.initState();
    print('In InitState = The value of Counter is $_counter');
    initPrefs();
  }

  //Using the Future class to load the data from SharedPreferences
  //More documentation on SharedPreferences
  //https://github.com/flutter/plugins/tree/master/packages/shared_preferences/shared_preferences
  //documentation:
  // https://api.dart.dev/stable/2.13.4/dart-async/Future-class.html
  Future<void> initPrefs() async {
    this.pref = await SharedPreferences.getInstance();
    _counter = this.pref?.getInt('counter') ?? 0;
    //if you don't call the _handleRefresh after the
    //counter value is initialized from the Future task, then
    //it wont be seen when you stop the AVD and start the AVD
    //on the load, it would set the value in the backend and will
    //show it correctly when you press the refresh button but not until then
    _handleRefresh();
    print('In InitPrefs = The value of Counter is $_counter');
  }

  //This is called to handle the refresh button click
  //we not only increment the counter, but also set it to the 
  //shared preferences object in the background. 
  void _handleRefresh() {
    setState(() {
      _counter++;
      this.pref?.setInt('counter', _counter);
      print('In HandleRefresh = The value of Counter is $_counter');
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        title: Text('Package Demos'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              //if you want to get the data from the preferences object directly
              //you can do so too.
              //'${(this.pref?.getInt("counter") ?? 0)}',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleRefresh,
        tooltip: 'Refresh',
        child: Icon(Icons.refresh),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
