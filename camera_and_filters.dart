import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:photofilters/photofilters.dart';

///Uses the following plugins
///photofilters: ^3.0.1
///image_picker: ^0.8.4+1
///TODO: make sure to add the necessary plugins in the pubspec.yaml

class CameraFilterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Picker Demo',
      home: CameraFilterPage(title: 'Camera and Photo Filter Example'),
    );
  }
}

class CameraFilterPage extends StatefulWidget {
  CameraFilterPage({Key? key, this.title}) : super(key: key);
  final String? title;
  @override
  _CameraFilterPageState createState() => _CameraFilterPageState();
}

class _CameraFilterPageState extends State<CameraFilterPage> {
  String? fileName;
  List<Filter> filters = presetFiltersList;
  File? imageFile;

  @override
  void initState() {
    super.initState();
  }

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              child: imageFile == null
                  ? Center(
                      child: Text('No image selected.'),
                    )
                  : Image.file(imageFile!),
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Semantics(
            label: 'image_picker_example_from_camera',
            child: FloatingActionButton(
              onPressed: () {
                _onImageButtonPressed(ImageSource.camera, context: context);
              },
              heroTag: 'image0', //make sure the hero tags are different
              //for different widgets otherwise it will give an error while
              //rebuilding the tree
              tooltip: 'Pick Image from camera',
              child: const Icon(Icons.camera_alt),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: FloatingActionButton(
              onPressed: () async {
                await getImage(context);
              },
              heroTag: 'image1',
              tooltip: 'Apply Filter to the Image',
              child: new Icon(Icons.filter),
            ),
          ),
        ],
      ),
    );
  }

  ///This is the API which calls the image picker to launch a
  ///a camera (or a gallery, based on what type of source is passed to it
  ///and will take a new picture (or choose a file from gallery)
  ///and return the file.
  void _onImageButtonPressed(ImageSource source,
      {BuildContext? context}) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
      );
      setState(() {
        imageFile = File(pickedFile!.path);
      });
    } catch (e) {
      print(e);
    }
  }

  /// API which is used to call the PhotoFilterSelector in a new page
  /// It displays the image passed and also the list of filters
  /// Once the user chooses a filter and applies it by using the check icon
  /// at the top right of the page, it returns the filtered image as the result
  /// which is then updated in the main page.
  Future getImage(context) async {
    fileName = basename(imageFile!.path);
    var image = imageLib.decodeImage(imageFile!.readAsBytesSync());
    image = imageLib.copyResize(image!, width: 600);

    //this is return NULL if you don't click on the "check" icon in the
    //photo filter selector page
    Map result = await Navigator.push(
      context,
      new MaterialPageRoute(
        builder: (context) => new PhotoFilterSelector(
          title: Text("Photo Filter Example"),
          filters: presetFiltersList,
          image: image!,
          filename: fileName!,
          loader: Center(child: CircularProgressIndicator()),
          fit: BoxFit.contain,
        ),
      ),
    );
    if (result.containsKey('image_filtered')) {
      setState(() {
        imageFile = result['image_filtered'];
      });
      print(imageFile!.path);
    }
  }
}
