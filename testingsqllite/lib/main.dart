import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'artist.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String databasePath = join(await getDatabasesPath(), 'chinook.db');
  print(databasePath); //This is the path used by the sqflite

// Only copy if the database doesn't exist
  if (FileSystemEntity.typeSync(databasePath) ==
      FileSystemEntityType.notFound) {
    // Load database from asset and copy
    ByteData data =
        await rootBundle.load(join(join('assets', 'databases'), 'chinook.db'));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    // Save copied asset to documents
    await new File(databasePath).writeAsBytes(bytes);
  }
  final database = openDatabase(
    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    join(await getDatabasesPath(), 'chinook.db'),
  );
  runApp(MyApp(database));
}

class MyApp extends StatelessWidget {
  Future<Database>? _db;
  List<Artist> artistList = [];

  MyApp(Future<Database> myDB) {
    this._db = myDB;

    artists();
  }
// Define a function that inserts artists into the database
  Future<void> insertArtist(Artist artist) async {
    // Get a reference to the database.
    final db = await _db;

    // Insert the artist into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same artist is inserted twice.
    //
    // In this case, replace any previous data.
    await db!.insert(
      'artists',
      artist.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Artist>> artists() async {
    // Get a reference to the database.
    final db = await _db;

    print("db = $db");

    // Query the table for all The artists.
    final List<Map<String, dynamic>> maps = await db!.query('artists');

    // Convert the List<Map<String, dynamic> into a List<artist>.
    return List.generate(maps.length, (i) {
      print(maps[i]['Name']);
      return Artist(
        ArtistId: maps[i]['ArtistId'],
        Name: maps[i]['Name'],
      );
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          //   // Column is also a layout widget. It takes a list of children and
          //   // arranges them vertically. By default, it sizes itself to fit its
          //   // children horizontally, and tries to be as tall as its parent.
          //   //
          //   // Invoke "debug painting" (press "p" in the console, choose the
          //   // "Toggle Debug Paint" action from the Flutter Inspector in Android
          //   // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          //   // to see the wireframe for each widget.
          //   //
          //   // Column has various properties to control how it sizes itself and
          //   // how it positions its children. Here we use mainAxisAlignment to
          //   // center the children vertically; the main axis here is the vertical
          //   // axis because Columns are vertical (the cross axis would be
          //   // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          //
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
