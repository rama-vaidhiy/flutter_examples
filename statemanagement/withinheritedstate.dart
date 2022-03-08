import 'package:flutter/material.dart';

///Look at the video for clear explanation of the inheritedwidget and its uses
///https://api.flutter.dev/flutter/widgets/InheritedWidget-class.html
///
///Lets create a class that represents the data that needs to be passed around
///In our case, its the counter which has the initial count and increment and
///decrement methods
class Counter {
  int count = 0;
  get currentCount => count;
  void incrementCounter() => count++;
  void decrementCounter() => count--;
  void initializeCounter() => count = 0;
}

///This is our InheritedWidget, again once this is written we don't change
///this much
class InheritedCounter extends InheritedWidget {
  //this is the entire state which is our data
  //this has to be final always
  //the inheritedWidget is immutable that is why it has to be final
  //so use the data which doesn't change. Mostly use this for creating
  //a service or some object that remains unchanged but whose property can change
  //in our case the Counter object isn't gonna change but the count value inside
  //the counter object will and that is OK.
  final Counter data;

  //we pass through the child and the state
  InheritedCounter({Key? key, required Widget child, required this.data})
      : super(key: key, child: child);
  //This is a built in method which you can use to check if
  //any state has changed. If not, no reason to rebuild all the widgets
  //that rely on your state.
  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  //This is the key method that will let the widgets which are its children
  //on how to get access to the state. This is the secret method that
  //you need to implement
  static InheritedCounter of(BuildContext context) {
    final InheritedCounter? result =
        context.dependOnInheritedWidgetOfExactType<InheritedCounter>();
    assert(result != null, 'No InheritedCounter found in context');
    return result!;
  }
}

void main() {
  runApp(
    //While creating the top level Widget element, you can make it the
    //inherited widget because we will use the same Counter object throughout
    //the widget tree
    InheritedCounter(
      data: Counter(),
      child: MaterialApp(
        title: 'Counter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(headline4: TextStyle(color: Colors.blue)),
        ),
        home: new HomePage(),
      ),
    ),
  );
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Counter? myCounter;
  @override
  Widget build(BuildContext context) {
    // This is how we access our store.
    // This container is where all our properties and methods live
    //because of the of(...) method implementation, it will go through
    //the tree from the current position to the top and will find the
    //the widget which is of the type InheritedCounter and will get the data
    //from it
    if (null == myCounter) myCounter = InheritedCounter.of(context).data;
    //this is used only for getting the data everything else can be done by the
    //container
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter with InheritedWidget'),
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            null != myCounter
                ? Text('The counter has been pressed ${myCounter!.count} times',
                    style: Theme.of(context).textTheme.headline4)
                : Text('Initialize the Counter first'),
          ],
        ),
      ),
      floatingActionButton: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myCounter!.incrementCounter();
              });
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              setState(() {
                myCounter!.decrementCounter();
              });
            },
            child: Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
