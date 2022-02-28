import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//Converting the sample counter application to
//use provider state management using the
//steps provided in
//https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple
//TODO: before using the code, make sure you have
//got provider included in your pubspec.yaml
//I have tested this with
//provider: ^6.0.2

//STEP 1:
//A ChangeNotifier (part of Flutter's foundation library)
// object is an *observable* object (from the Observable pattern)
//An observable class which will notify
//its listeners of any change to it
//in our case, whenever we increment the counter
//we notify the listeners of the value change
class Counter with ChangeNotifier {
  int counterValue = 0;

  //The only thing we would do with this object
  //is to increment its value (for now)
  //when we do, we notify the listener also
  void incrementValue() {
    counterValue++;
    print('Going to call notifyListeners, so all Consumers will be notified');
    notifyListeners();
  }
}

//STEP 2:
//Use the ChangeNotifierProvider (from the provider package)
//as the main widget
//ChangeNotifiderProvider as the name indicates
//provides the ChangeNotifier object to all its children/descendants
//in the widget tree.
//hence the reason for it to be at the top of the application tree
//ideally place this in the location of the widget tree, where
//the descendants needs the ChangeNotifier object.

void main() {
  runApp(
    //It takes in a create parameter which should be the
    //ChangeNotifier object and then the child of the widget (sub)tree
    //According to the documentation:
    //To create a value, use the default constructor.
    // Creating the instance inside build using ChangeNotifierProvider.value
    // will lead to memory leaks and potentially undesired side-effects.
    //hence be careful to use the default constructor here.
    ChangeNotifierProvider(
      create: (context) => Counter(),
      child: MyApp(),
    ),
  );
}

//STEP 2: ADDITIONAL NOTE: if you have more than one ChangeNotifier
//objects to be used in your application, instead of ChangeNotifierProvider
//use MultiProvider object, which takes in providers array instead of create.

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo using Provider Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //STEP 3: REMOVE UNNECESSARY CODE:
  // these are removed as they have been
  //moved to the ChangeNotifier object
  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            //STEP 3: REMOVE UNNECESSARY CODE:
            //We need to place this with code not as is, but inside
            //something else, but for now, comment it
            //as it wont work because we are not having a counter variable
            // Text(
            //   '$_counter',
            //   style: Theme.of(context).textTheme.headline4,
            // ),
            //STEP 4: adding a Consumer to use the ChangeNotifier object
            //that has been set in the root
            Consumer<Counter>(
              builder: (BuildContext context, Counter value, Widget? child) {
                //This is where we build the Text widget with the value
                //from the Counter object and return it.
                //the following code is the same as the commented one, but
                //is now placed inside
                print('Consumer is notified when notifyListeners is called');
                return Text('${value.counterValue}',
                    style: Theme.of(context).textTheme.headline4);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        //STEP 3: REMOVE UNNECESSARY CODE:
        //Need to replace this with other way of using the
        //ChangeNotifier object
        // onPressed: _incrementCounter,
        onPressed: () {
          //STEP 5: now that we have made sure that
          //we are using the ChangeNotifier object in the display
          //we need to be able to call the incrementCounter of that
          //to update too. We do that using Provider.of(context)
          //or context.read
          //We can use either of these
          //method 1
          //Provider.of<Counter>(context, listen: false).incrementValue();
          //method 2
          context.read<Counter>().incrementValue();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
