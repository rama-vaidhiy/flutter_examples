import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:xml/xml_events.dart';
//TODO: make sure to include xml: ^5.1.2 in your pubspec.yaml
//to use the xml events
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter XML - RSS Feed Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(
        title: 'Flutter XML - RSS Feed Page',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Map<String, String> feedSources = {
    'Sky': 'https://feeds.skynews.com/feeds/rss/world.xml',
    'NHS': 'https://digital.nhs.uk/feed/newsfeed.xml',
    'InfoQ': 'https://feed.infoq.com/',
  };
  String dropdownValue = 'Sky';
  
  List<NewsItem> newsItems = List<NewsItem>.empty(growable: true);
 
  void loadFeed() async {
    newsItems = List<NewsItem>.empty(growable: true);
    String? uritoparse = feedSources.containsKey(dropdownValue)
        ? feedSources[dropdownValue]
        : 'https://feeds.skynews.com/feeds/rss/world.xml';
    final url = Uri.parse(uritoparse!);
    final request = await HttpClient().getUrl(url);
    final response = await request.close();

    String currentElement = '';
    await response
        .transform(utf8.decoder)
        .toXmlEvents()
        .selectSubtreeEvents((event) => event.name == 'item')
        .normalizeEvents()
        .forEachEvent(
      onText: (event) {
        if (currentElement.isNotEmpty &&
            currentElement == 'title' &&
            event.text.trim().isNotEmpty) {
          NewsItem n = NewsItem(title: event.text.trim(), link: '');
          setState(() {
            newsItems.add(n);
          });
        }
      },
      onStartElement: (event) {
        currentElement = event.name;
      },
    );
   
  }

  //calling the init state to fill a list variable with all the necessary widgets
  @override
  void initState() {
    loadFeed();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          key: ValueKey(10),
        ),
      ),
      body: Column(
        children: [
          DropdownButton(
            value: dropdownValue,
            items: feedSources.keys.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textScaleFactor: 2.0,
                ),
              );
            }).toList(),
            // After selecting the desired option,it will
            // change button value to selected value
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
                loadFeed();
              });
            },
          ),
          Divider(),
          Container(
           
            child: Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                itemCount: newsItems.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        newsItems[index].title,
                        textScaleFactor: 1.5,
                      ),
                    ),
                  );
                },
               
              ),
            ),
          ),
        ],
      ),
     
    );
  }
}

class NewsItem {
  String title;
  String link;

  NewsItem({required this.title, required this.link});
}
