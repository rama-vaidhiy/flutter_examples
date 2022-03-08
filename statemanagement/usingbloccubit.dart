import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

///This example uses Bloc (Business Logic Components) developed by Google
///It uses streams and sinks to handle data flow there by making the pattern
///reactive.
///
/// To use these examples TODO add the plugin flutter_bloc: ^8.0.1
/// In this example we will use the Cubit version of Bloc
/// https://bloclibrary.dev/#/coreconcepts?id=cubit
///Cubit uses **functions** to trigger state changes.
///Make the data that will be shared a Cubit (by extending it) and
///identifying the type of data that it will hold. In this case, it holds an int
///and identify the state change using emit. Each emit will set a new state
class Counter extends Cubit<int> {
  Counter() : super(0);
  void incrementCounter() => emit(state + 1);
  void decrementCounter() => emit(state - 1);

  ///You can monitor, even analyse, or log the state change by overriding
  ///the onChange. There are few such methods you can use.
  @override
  void onChange(Change<int> change) {
    super.onChange(change);
    print(change);
  }
}

///Just like we have the ScopedModel in scoped_model, ChangeNotifyProvider etc
///we use the BlockProvider with the Cubit type (i.e. Counter in this case)
///in the top level of the widget tree where the data will be shared across
///While creating the BlocProvider we also ensure that the cubit is created
///for everyone to use.
void main() {
  runApp(
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
        title: Text('Counter with Bloc Cubit'),
      ),
      body: new Center(
        ///Now we associate the individual widget/widget subtree with as the
        ///consumer of the Cubit by wrapping them up in the BlocBuilder.
        ///This is similar to the use of Consumer in provider, ScopedDependantModel in
        ///scoped_model etc. This is identified by the Cubit and the type of data
        ///that is being provided by the builder
        ///The builder will provide the context and the value (for the int)
        ///We can use the int value which comes from the Cubit.
        ///This will automatically listen to any state change and will rebuild
        ///the UI when there is a state change (no setState required)
        child: BlocBuilder<Counter, int>(
          builder: (context, count) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'The counter has been pressed $count times',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          FloatingActionButton(
            onPressed: () {
              ///Now to the place where we call the **function** that will
              ///ensure the state change in the Cubit
              ///We use the Context's read of the Cubit type (i.e. Counter)
              ///and get the instance of Counter and call the respective
              ///function to trigger the state change.
              ///When this is called, the onChange in the Cubit gets triggered
              ///and the BlocProvider's are notified.
              context.read<Counter>().incrementCounter();
            },
            child: Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () {
              ///Now to the place where we call the **function** that will
              ///ensure the state change in the Cubit
              ///We use the Context's read of the Cubit type (i.e. Counter)
              ///and get the instance of Counter and call the respective
              ///function to trigger the state change.
              ///When this is called, the onChange in the Cubit gets triggered
              ///nd the BlocProvider's are notified.
              context.read<Counter>().decrementCounter();
            },
            child: Icon(Icons.minimize),
          ),
        ],
      ),
    );
  }
}
