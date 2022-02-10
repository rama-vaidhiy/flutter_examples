import 'package:flutter/material.dart';

class Nav1App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nav1 App',
      onGenerateRoute: (settings) {
        // Handle '/'
        if (settings.name == '/') {
          return MaterialPageRoute(builder: (context) => HomeScreen());
        }

        // Handle '/details/:id'
        var uri = Uri.parse(settings.name!);
        if (uri.pathSegments.length == 2 &&
            uri.pathSegments.first == 'details') {
          var id = uri.pathSegments[1];
          return MaterialPageRoute(builder: (context) => DetailScreen(id: id));
        }

        return MaterialPageRoute(builder: (context) => UnknownScreen());
      },
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return TextButton(
              child: Text(
                'View Details of item $index',
                textScaleFactor: 1.5,
              ),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  '/details/$index',
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class DetailScreen extends StatelessWidget {
  String? id;

  DetailScreen({
    this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Viewing details for item $id',
              textScaleFactor: 1.5,
            ),
            TextButton(
              child: Text('Return!'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text('404!'),
      ),
    );
  }
}
