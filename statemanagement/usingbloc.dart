import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///This example uses Bloc (Business Logic Components) developed by Google
///It uses streams and sinks to handle data flow there by making the pattern
///reactive.
///
/// To use these examples TODO add the plugin flutter_bloc: ^8.0.1
/// In this example we will use the Cubit version of Bloc
/// https://bloclibrary.dev/#/coreconcepts?id=bloc
///Bloc uses **events** to trigger state changes.
///Once this is tested, identify the key differences between Cubit and Bloc
///https://bloclibrary.dev/#/coreconcepts?id=cubit-vs-bloc
///In order to create the bloc we need
///a) the events, we create a abstract event called CounterEvent and
///create the necessary Events for the Counter
///b) Create the Bloc by extending it from Bloc with the Event and the data
///that will be stored and changed as and when the events are triggered
abstract class CounterEvent {}

class CounterIncrementEvent extends CounterEvent {}

class CounterDecrementEvent extends CounterEvent {}

///Extend the Block and in the constructor, identify the
///various events and the actions that need to be taken to do the
///state change. Remember the state change still happens by calling the emit
///
class Counter extends Bloc<CounterEvent, int> {
  Counter() : super(0) {
    on<CounterIncrementEvent>((event, emit) => _incrementCounter());
    on<CounterDecrementEvent>((event, emit) => _decrementCounter());
  }

  ///Note that these functions which were public in Cubit are not private
  ///and are used only when the events are triggered. These should not be
  ///invoked from anywhere else.
  void _incrementCounter() => emit(state + 1);
  void _decrementCounter() => emit(state - 1);

  ///We can still monitor, analyse, or log the state changes using onChange
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print('OnChange $change');
  }
}

void main() {
  runApp(
    ///Just like we have the ScopedModel in scoped_model, ChangeNotifyProvider etc
    ///we use the BlockProvider with the Bloc type (i.e. Counter in this case)
    ///in the top level of the widget tree where the data will be shared across
    ///While creating the BlocProvider we also create an instance of the Bloc
    ///which can then be passed on to other widgets in the app.
    BlocProvider<Counter>(
      create: (context) => Counter(),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter with Bloc Event'),
      ),
      body: new Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ///Just like the example in the Cubit, we use the BlocBuilder
            ///to keep track of the state changes. The BlocBuilder has been
            ///moved to creating the text instead of the Column itself
            ///to show that we can make them as specific as we want.
            ///If we have it just as we had it for Cubit example and create this
            ///at Column level it will still work.
            BlocBuilder<Counter, int>(builder: (context, count) {
              return Text(
                'The counter has been pressed $count times',
                style: Theme.of(context).textTheme.headline4,
              );
            }),
          ],
        ),
      ),
      floatingActionButton: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              ///This is where the state changes are triggered, Just like in
              ///Cubit example we are using the context's read and triggering
              ///the *event* and not the function. This is where the key
              ///difference lies between the Cubit and the Bloc
              context.read<Counter>().add(CounterIncrementEvent());
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              ///This is where the state changes are triggered, Just like in
              ///Cubit example we are using the context's read and triggering
              ///the *event* and not the function. This is where the key
              ///difference lies between the Cubit and the Bloc
              context.read<Counter>().add(CounterDecrementEvent());
            },
            child: Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
