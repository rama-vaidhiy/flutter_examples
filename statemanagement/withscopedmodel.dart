import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

///TODO: make sure to add the scoped_model package to the pubspec.yaml
///scoped_model: ^1.1.0
///TODO: while you are running this example, you might have to use
///--no-sound-null-safety option as scoped_model version used above
///doesn't support null-safety features yet.
///More documentation can be found at
///https://pub.dev/packages/scoped_model
///this is the same as the inherited widget but most of the code
///is hidden to you and all you need to do is mark the Counter class
///as a Model and whenever you do any action, call the notifyListeners
///so that any need for widget redrawing can happen automatically as long
///as they are within the Scoped range.
class Counter extends Model {
  int count = 0;
  get currentCount => count;
  void incrementCounter() {
    count++;
    //this is important.
    notifyListeners();
  }

  void decrementCounter() {
    count--;
    //dont forget this again.
    notifyListeners();
  }
}

void main() {
  runApp(
    ///Just like our InheritedWidget, wrap the top level widget
    ///or any other top level subtree widget which would hold the data
    ///that gets passed around in a ScopedModel object. The ScopedModel will
    ///take in the Model object you have created which is our Counter class
    ///make sure to pass this to the model: argument without fail.
    ScopedModel<Counter>(
      model: Counter(),
      child: MaterialApp(
        title: 'Counter',
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
        title: Text('Counter with ScopedModel'),
      ),
      body: new Center(
        ///now whereever we need our Counter object all we need to do is
        ///ensure that the specific widget which will access the Counter class
        ///is wrapped in the ScopedModelDescendant object and the widget is
        ///built using the builder function which provides the model to the child
        ///that you will add.
        ///in this case, the Column with the Text is created and it is using
        ///the model which in turn is the Counter objected created at the top
        child: ScopedModelDescendant<Counter>(
          builder: (context, child, model) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                null != model
                    ? Text('The counter has been pressed ${model.count} times')
                    : Text('Initialize the Counter first'),
              ],
            );
          },
        ),
      ),
      floatingActionButton: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.center,
        children: [
          ///we can also use the same ScopedModelDescendant to our FloatingAction
          ///buttons which will use the model to do the actions
          ///As you can see we are not using any setState and that is because
          ///the notifyListeners will let the ScopedModelDescendants know
          ///of any change and will automatically enable a redrawing of the
          ///widget.
          ScopedModelDescendant<Counter>(
            builder: (context, child, model) {
              return FloatingActionButton(
                onPressed: () {
                  model.incrementCounter();
                },
                child: Icon(Icons.add),
              );
            },
          ),
          ScopedModelDescendant<Counter>(
            builder: (context, child, model) {
              return FloatingActionButton(
                onPressed: () {
                  model.decrementCounter();
                },
                child: Icon(Icons.minimize),
              );
            },
          ),
        ],
      ),
    );
  }
}
