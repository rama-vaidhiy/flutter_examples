import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //displayed before the title of the App
        //usually set to IconButton or BackButton
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {}, //no actions handled for now
        ),
        //the title of the App
        title: Text('Home'),
        //actions are displayed to the right of the title.
        //these can be IconButton or PopupMenuButton
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {}, //no actions handled for now
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {}, //no actions handled for now
          ),
        ],
        //flexibleSpace is stacked behind the Toolbar or TabBar
        // widget. The height is usually same as the AppBar widget’s height.
        // A background image is commonly applied to the
        // flexibleSpace property, but any widget, such as an Icon,
        // could be used.
        flexibleSpace: SafeArea(
          child: Icon(
            Icons.photo_camera,
            size: 75.0,
            color: Colors.white70,
          ),
        ),
        bottom: PreferredSize(
          child: Container(
            color: Colors.blue.shade100,
            height: 75.0,
            width: double.infinity,
            child: Center(
              child: Text('Bottom'),
            ),
          ),
          preferredSize: Size.fromHeight(75.0),
        ),
      ),
      body: SafeArea(
        child: Text(
          'Body Content goes here',
          textScaleFactor: 2.0,
        ),
      ),
    );
  }
}
