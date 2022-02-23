import 'package:flutter/material.dart';
import 'package:flutterforms/stepbystepforforms.dart';

void main() {
  runApp(SampleFormPage());
}

class SampleFormPage extends StatelessWidget {
  const SampleFormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sample Form',
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Simple Form'),
        ),
        //    body: ProperForm(),
        body: BasicForm(),
      ),
    );
  }
}
