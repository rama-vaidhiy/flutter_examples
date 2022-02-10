import 'package:flutter/material.dart';

class Nav2App extends StatefulWidget {
  const Nav2App({Key? key}) : super(key: key);

  @override
  _Nav2AppState createState() => _Nav2AppState();
}

class _Nav2AppState extends State<Nav2App> {
  bool errorPage = false;
  int chosenId = 0;
  void _handleClickOnHomeScreen(int idChosen) {
    setState(() {
      chosenId = idChosen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nav2 App',
      //move this to the router delegate too
      home: Navigator(
        pages: [
          MaterialPage(
              key: ValueKey('ListPage'),
              child: HomeScreenNew(_handleClickOnHomeScreen)),
          if (errorPage)
            MaterialPage(key: ValueKey('ErrorPage'), child: UnknownScreen())
          else if (chosenId > 0)
            MaterialPage(
                key: ValueKey(chosenId),
                child: DetailScreenNew(
                  id: chosenId,
                ))
        ],
        onPopPage: (route, result) {
          print('onPopPage');
          if (!route.didPop(result)) {
            return false;
          }
          setState(() {
            print('setting the chosenid to 0');
            chosenId = 0;
          });
          return true;
        },
      ),
    );
  }
}

class HomeScreenNew extends StatelessWidget {
  final ValueChanged<int> onClicked;
  HomeScreenNew(this.onClicked);
  int chosenId = 0;
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
            int actualValue = index + 1;
            return TextButton(
              child: Text(
                'View Details of item $actualValue',
                textScaleFactor: 1.5,
              ),
              onPressed: () => onClicked(actualValue),
            );
          },
        ),
      ),
    );
  }
}

class DetailScreenNew extends StatelessWidget {
  int? id;

  DetailScreenNew({
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
