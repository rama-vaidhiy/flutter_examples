import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'supportingclasses.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
            bodyText1: TextStyle(fontSize: 22.0, color: Colors.green),
            bodyText2: TextStyle(fontSize: 20.0, color: Colors.red),
            subtitle1: TextStyle(fontSize: 22.0, color: Colors.blue)),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _usersList = [];
  Client client = Client();
  var _url = Uri.https('jsonplaceholder.typicode.com', '/users');

  Future<List<User>> _fetchPostsFromWeb() async {
    print('Enters fetch posts from web method - using GET HTTP Method');

    print('Trying to use the http package now');
    var response =
        await client.get(_url); //invoke the GET request and get the response

    if (response.statusCode == 200) {
      //if the response is successful
      String responseBody = response.body; //get the body of the response;
      // remember that the response can also have headers and other such details
      //that is why we extract the body
      final convertedJsonObject = jsonDecode(responseBody)
          .cast<Map<String, dynamic>>(); //convert it to jsonObject
      //mostly this would be a Map<String, dynamic> because all json will have
      //is a key and a value.. the key will always be a string and the value
      //can be of any type (array, object, string, int etc.)
      _usersList = convertedJsonObject
          .map<User>((json) => User.fromJson(json))
          .toList(); //from that using the object of our custom class convert it to a list.

      var itemCount = _usersList.length;

      print('Number of users retrieved about http: $itemCount.');
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return _usersList;
  }

  Widget listViewBuilder(BuildContext context, List<dynamic> values) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: values.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text((values[index].id).toString()),
              title: Text((values[index].name)),
              subtitle: Text((values[index].username)),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    var futureBuilder = new FutureBuilder(
        initialData: [],
        future: _fetchPostsFromWeb(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Text('Press button to start.');
            case ConnectionState.active:
              sleep(const Duration(seconds: 5));
              return Text('Awaiting result...');
            case ConnectionState.waiting:
              sleep(const Duration(seconds: 5));
              return Text('Awaiting result...');
            case ConnectionState.done:
              if (snapshot.hasError) return Text('Error: ${snapshot.error}');
              return listViewBuilder(context, snapshot.data);
            default:
              return Text('Some error occurred');
          }
        });

    return Scaffold(
      appBar: AppBar(
        title: Text('Checking for HTTP'),
      ),
      body: Center(
        child: Column(
          children: [
            futureBuilder,
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewUser,
        child: Icon(Icons.add),
      ),
    );
  }

  void _addNewUser() async {
    _usersList[0].name = 'rama';
    var encodedRequest = _usersList[0].toJson();
    print("sending $encodedRequest");
    var postResponse = await client.post(_url,
        headers: {
          'content-type': 'application/json',
          'accept': 'application/json'
        },
        body: jsonEncode(encodedRequest));
    final postResponseData =
        jsonDecode(postResponse.body) as Map<String, dynamic>;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${postResponseData['id']} has been added '),
      ),
    );
    print('getting back what has been sent  $postResponseData');
  }
}

class Post {
  int userId = 0;
  int id = 0;
  String title = '';
  String body = '';
  Post(
      {required this.userId,
      required this.id,
      required this.title,
      required this.body});

  /**
   * In this we are just converting our Post object into a JSON entry.
   * We are just setting the appropriate JSON properties with their values
   * from the Post object.
   * this is called when we are posting data using Http POST requests.
   */
  Map<String, dynamic> toJson() => {
        'userId': userId,
        'id': id,
        'title': title,
        'body': body,
      };

  /**
   * To convert the Map that we receive from the response to our GET requests,
   * we write a factory method for the class. This takes in the Map<String,dynamic>
   *   argument and creates a new Post for us.
   *   What we are doing here is for every property in the received Map,
   *   we are associating it with the field we have in our Post class and then
   *   returning the Post object.
   *   This is called when we are trying to decode the JSON response into our custom
   *   object
   */
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'] as int,
      id: json['id'] as int,
      title: json['title'] as String,
      body: json['body'] as String,
    );
  }
}
