import 'package:flutter/material.dart';

class Nav21App extends StatefulWidget {
  const Nav21App({Key? key}) : super(key: key);

  @override
  _Nav21AppState createState() => _Nav21AppState();
}

class _Nav21AppState extends State<Nav21App> {
  ListRouterDelegate _routerDelegate = ListRouterDelegate();
  ListViewInfoParser _routeInformationParser = ListViewInfoParser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        routeInformationParser: _routeInformationParser,
        routerDelegate: _routerDelegate);
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

class ListItemsRoutePath {
  final int id;
  final bool isUnknown;

  ListItemsRoutePath.home()
      : isUnknown = false,
        id = 0;
  ListItemsRoutePath.details(this.id) : isUnknown = false;
  ListItemsRoutePath.unknown()
      : isUnknown = true,
        id = -1;
  bool get isHomePage => id == 0;
  bool get isDetailsPage => id > 0;
}

class ListRouterDelegate extends RouterDelegate<ListItemsRoutePath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<ListItemsRoutePath> {
  final GlobalKey<NavigatorState> navigatorKey;
  ListRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();
  bool errorPage = false;
  int chosenId = 0;

  @override
  //do the building of the navigator to help with the routing
  Widget build(BuildContext context) {
    print('Build of RouterDelegate');
    return Navigator(
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

        print('setting the chosenid to 0');
        chosenId = 0;
        errorPage = false;
        notifyListeners();

        return true;
      },
    );
  }

  @override
  Future<void> setNewRoutePath(ListItemsRoutePath configuration) async {
    print('SetNew Route Path');
    if (configuration.isUnknown) {
      chosenId = -1;
      errorPage = true;
      return;
    }
    if (configuration.isDetailsPage) {
      if (configuration.id < 1 && configuration.id > 10) {
        errorPage = true;
        chosenId = -1;
        return;
      }
      chosenId = configuration.id;
    }
    if (configuration.isHomePage) {
      chosenId = 0;
    }
    errorPage = false;
  }

  @override
  //Deals with all the routing algorithm between pages
  ListItemsRoutePath? get currentConfiguration {
    print('getCurrentConfiguration');
    if (errorPage) {
      return ListItemsRoutePath.unknown();
    }
    if (chosenId == 0) {
      return ListItemsRoutePath.home();
    }
    return ListItemsRoutePath.details(chosenId);
  }

  void _handleClickOnHomeScreen(int idChosen) {
    print('clicked on an item');
    chosenId = idChosen;
    notifyListeners();
  }
}

class ListViewInfoParser extends RouteInformationParser<ListItemsRoutePath> {
  @override
  Future<ListItemsRoutePath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location!);
    print('Uri = $uri Uri pathsegments = ${uri.pathSegments}');

    if (uri.pathSegments.length == 0) {
      print('parseRouteInformation returning ListItemsRoutePath.home()');
      return ListItemsRoutePath.home();
    }
    // Handle '/details/:id'
    if (uri.pathSegments.length == 2) {
      if (uri.pathSegments[0] != 'details') return ListItemsRoutePath.unknown();
      var remaining = uri.pathSegments[1];
      var id = int.tryParse(remaining);
      if (id == null) return ListItemsRoutePath.unknown();
      print('parseRouteInformation returning ListItemsRoutePath.details(id)');
      return ListItemsRoutePath.details(id);
    }

    // Handle unknown routes
    return ListItemsRoutePath.unknown();
  }

  @override
  RouteInformation? restoreRouteInformation(ListItemsRoutePath configuration) {
    print(
        'restoreRouterInformation  ${configuration.isUnknown} ${configuration.isHomePage} ${configuration.isDetailsPage} ');
    if (configuration.isUnknown) {
      print(
          'creates the route information for error page with location set to /404');
      return RouteInformation(location: '/404');
    }
    if (configuration.isHomePage) {
      print(
          'creates the route information for home page with location set to /');
      return RouteInformation(location: '/');
    }
    if (configuration.isDetailsPage) {
      print(
          'creates the route information for details page with location /details/${configuration.id} ');
      return RouteInformation(location: '/details/${configuration.id}');
    }
    return null;
  }
}
