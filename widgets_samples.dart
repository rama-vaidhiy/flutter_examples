import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CommonWidgetsHome extends StatefulWidget {
  const CommonWidgetsHome({Key? key}) : super(key: key);

  @override
  _CommonWidgetsHomeState createState() => _CommonWidgetsHomeState();
}

class _CommonWidgetsHomeState extends State<CommonWidgetsHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Widget List'),
      ),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                const CustomContainerWidget(),
                Divider(),
                const CustomRichText(),
                Divider(),
                const CustomColumnWidget(),
                Divider(),
                const CustomRowWidget(),
                Divider(),
                ColumnRowsNestedWidget(),
                Divider(),
                CustomButtonsWidget(),
                Divider(),
                CustomButtonBarWidget(),
                Divider(),
                //Adding a circle avatar to show how it looks
                CircleAvatar(
                  child: Image.network('https://picsum.photos/200'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Add a Container with text and some decorations
class CustomContainerWidget extends StatelessWidget {
  const CustomContainerWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      child: Center(
        child: Text('I\'m in a container'),
      ),
      decoration: BoxDecoration(
        color: Colors.yellowAccent,
        gradient: LinearGradient(
          colors: [
            Colors.orange,
            Colors.deepOrange,
          ],
        ),
        boxShadow: [
          BoxShadow(color: Colors.grey, blurRadius: 5.0),
        ],
      ),
    );
  }
}

//Custom Rich Text widget with some fancy styling
//instead of adding plain text widgets
class CustomRichText extends StatelessWidget {
  const CustomRichText({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: 'Hello Flutter',
        style: TextStyle(
          color: Colors.green,
          fontSize: 20.0,
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }
}

//Lets add a custom Column widget with some text widgets in it
class CustomColumnWidget extends StatelessWidget {
  const CustomColumnWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('Column entry 1'),
        Divider(),
        Text('Column entry 2'),
        Divider(),
        Text('Column entry 3'),
      ],
    );
  }
}

//Creating a custom Row widget class and adding some texts in it
class CustomRowWidget extends StatelessWidget {
  const CustomRowWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Row entry 1'),
        // Divider(),//do not use divider in row coz it will use a lot of space
        //use padding between them if you want space
        Padding(
          padding: EdgeInsets.all(10.0),
        ),
        Text('Row entry 2'),
        Padding(
          padding: EdgeInsets.all(10.0),
        ),
        Text('Row entry 3'),
      ],
    );
  }
}

//RowsInAColumn Widget
class ColumnRowsNestedWidget extends StatelessWidget {
  const ColumnRowsNestedWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      verticalDirection: VerticalDirection.up,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        Text('Nested column entry 1'),
        Text('Nested column entry 2'),
        Text('Nested column entry 3'),
        Padding(
          padding: EdgeInsets.all(10.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('column-row entry 1'),
            Text('column-row entry 2'),
          ],
        ),
      ],
    );
  }
}

//Adding a column of row of buttons of different types
class CustomButtonsWidget extends StatelessWidget {
  const CustomButtonsWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        //add a row of Text buttons
        Row(
          children: [
            //adding a simple text button
            TextButton(
              onPressed: () {
                print('pressed the Text Button');
              },
              child: Text('Text Button 1'),
            ),
            //adding a Text button with some properties
            TextButton(
              onPressed: () {
                print('pressed the Text Button');
              },
              child: Icon(
                Icons.add_reaction,
                color: Colors.teal,
              ),
            ),
          ],
        ),
        //add a row of Elevated buttons
        Row(
          children: [
            //simple elevated button
            ElevatedButton(
              onPressed: () => {},
              child: Text('Elevated Button'),
            ),
            //elevated button with icons set
            ElevatedButton(
              onPressed: () => {},
              child: Center(
                child: Icon(
                  Icons.volume_up,
                ),
              ),
            ),
          ],
        ),
        //row of icon button
        Row(
          children: [
            //simple icon button
            IconButton(
              onPressed: () => {},
              icon: Icon(Icons.accessibility),
            ),
            //icon button with some properties set
            IconButton(
              onPressed: () => {},
              icon: Icon(
                Icons.add_road,
              ),
              iconSize: 25.0,
              highlightColor: Colors.cyan,
              tooltip: 'Add Road',
            ),
          ],
        ),
      ],
    );
  }
}

//Custom button bar widget with three icon buttons in it.
class CustomButtonBarWidget extends StatelessWidget {
  const CustomButtonBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.spaceEvenly,
      children: [
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {},
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          highlightColor: Colors.purple,
          onPressed: () {},
        ),
      ],
    );
  }
}
