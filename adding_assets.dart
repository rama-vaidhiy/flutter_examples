import 'package:flutter/material.dart';

class ImageDisplayWidget extends StatelessWidget {
  const ImageDisplayWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          //one way to get the images from the asset
          Image(
            image: AssetImage(
              'images/mandala1.png',
            ),
          ),
          //or use the Image.asset directly
          Image.asset('images/mandala2.png'),
        ],
      ),
    );
  }
}

//For this to work, you need to have to create an images directory
//and add images of your choice and update the directory of the images in 
//pubspec.yaml as given below

//flutter:
//  uses-material-design: true
//  assets:
//  #to add all images from the directory just give images/
//    - images/mandala1.png
//    - images/mandala2.png
