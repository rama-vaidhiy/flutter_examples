import 'package:flutter/material.dart';

import 'nav21.dart';

void main() {
  runApp(Nav21App());
}
//
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   final delegate = MyRouteDelegator();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Router(routerDelegate: delegate),
//     );
//   }
// }
//
// //Create a Home Page (extending the Page)
// class MyHomePage extends Page {
//   @override
//   Route createRoute(BuildContext context) {
//     return MaterialPageRoute(builder: (BuildContext context) {
//       return MyHomeScreen();
//     });
//   }
// }
//
// //Create the corresponding UI widget for the page
// class MyHomeScreen extends StatelessWidget {
//   const MyHomeScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('HomeScreen'),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//             onPressed: () {
//               print('Pressed the button for now');
//             },
//             child: Text('I am home'),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// //Create the 2nd page
// class Screen1 extends Page {
//   @override
//   Route createRoute(BuildContext context) {
//     return MaterialPageRoute(builder: (BuildContext context) {
//       return Screen1UI();
//     });
//   }
// }
//
// //The widget corresponding to the 2nd page
// class Screen1UI extends StatelessWidget {
//   const Screen1UI({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen1'),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//             onPressed: () {
//               print('Pressed the button for now');
//             },
//             child: Text('I am in Screen 1'),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// //Another Page
// class Screen2 extends Page {
//   @override
//   Route createRoute(BuildContext context) {
//     return MaterialPageRoute(builder: (BuildContext context) {
//       return Screen2UI();
//     });
//   }
// }
//
// //Another widget for the another page
// class Screen2UI extends StatelessWidget {
//   const Screen2UI({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Screen2'),
//       ),
//       body: Column(
//         children: [
//           TextButton(
//             onPressed: () {
//               print('Pressed the button for now');
//             },
//             child: Text('I am in Screen 2'),
//           )
//         ],
//       ),
//     );
//   }
// }
//
// class MyRouteDelegator extends RouterDelegate
//     with ChangeNotifier, PopNavigatorRouterDelegateMixin {
//   @override
//   Widget build(BuildContext context) {
//     return Navigator(
//       key: navigatorKey,
//       onPopPage: _handlePopPage,
//       pages: [
//         MyHomePage(),
//         Screen1(),
//         Screen2(),
//       ],
//     );
//   }
//
//   bool _handlePopPage(Route<dynamic> route, result) {
//     if (!route.didPop(result)) {
//       return false;
//     }
//     return true;
//   }
//
//   // final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
//   @override
//   //implement navigatorKey
//   GlobalKey<NavigatorState>? get navigatorKey => GlobalKey<NavigatorState>();
//
//   @override
//   Future<void> setNewRoutePath(configuration) async {}
//
//   @override
//   Future<bool> popRoute() {
//     return Future.value(false);
//   }
// }
