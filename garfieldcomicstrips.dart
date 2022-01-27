import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print(context.widget);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyGarfieldComicPage(),
    );
  }
}

class MyGarfieldComicPage extends StatefulWidget {
  const MyGarfieldComicPage({Key? key}) : super(key: key);
  static const List<String> comicURLs = [
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Garfield-I-Hate-Mondays-Wallpaper.jpg',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Garfield-and-Mondays.jpg',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Best-Garfield-I-Hate-Mondays-Wallpaper-Image.png',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Garfield-I-hate-Mondays-image.jpg',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Garfield-I-Hate-Mondays-Meme.jpg',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Garfield-Monday-Morning.jpg',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Garfield-Monday-the-13th.jpg',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Garfield-the-cat-I-hate-mondays.jpg',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/I-hate-Mondays-Pictures.jpg',
    'https://cdn-0.therandomvibez.com/wp-content/uploads/2017/07/Garfield-I-Hate-Mondays-Wallpaper.jpg',
  ];

  @override
  _MyGarfieldComicPageState createState() =>
      _MyGarfieldComicPageState(urls: comicURLs);
}

class _MyGarfieldComicPageState extends State<MyGarfieldComicPage> {
  _MyGarfieldComicPageState({required this.urls});

  List<String> urls;
  int _imageIndex = 0;

  void _updateImageIndex() {
    setState(() {
      _imageIndex = Random().nextInt(this.urls.length - 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    print("inside build function");

    return Scaffold(
      appBar: AppBar(
        title: Text('Garfield Comics'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(urls[_imageIndex]),
          ),
        ],
      ),
      floatingActionButton: new Builder(builder: (context) {
        return new FloatingActionButton(
          onPressed: () {
            _updateImageIndex();
            //just to illustrate the use of context to do some actions.
            ScaffoldMessenger.of(context).showSnackBar(
              new SnackBar(
                backgroundColor: Colors.blue,
                content: new Text('Howzzat!!! \u{1f600}'),
              ),
            );
          },
          child: Icon(Icons.refresh),
        );
      }),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     _updateImageIndex();
      //   },
      //   child: Icon(Icons.refresh),
      // ),
    );
  }
}
