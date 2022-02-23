import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterforms/moreform.dart';

class BasicForm extends StatefulWidget {
  const BasicForm({Key? key}) : super(key: key);

  @override
  _BasicFormState createState() => _BasicFormState();
}

class _BasicFormState extends State<BasicForm> {
  TextEditingController editingController = TextEditingController();
  String inputTextValue = 'None';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]+[A-Z]*')),
          ],
          controller: editingController,
          decoration: InputDecoration(
            // errorText:
            //     'The name should start with a digit followed by capital letters',
            labelText: 'What\'s your name',
            labelStyle: TextStyle(fontSize: 25),
          ),
          autofocus: true,
          autocorrect: true,
          onChanged: (value) {
            print('onchanged $value');
          },
          onEditingComplete: () {
            print('oneditingcomplete');
          },
          onSubmitted: (value) {
            print('onsubmitted $value');
            addTextToColumn();
          },
        ),
        TextButton(
          onPressed: addTextToColumn,
          child: Text('Submit', style: TextStyle(fontSize: 35)),
        ),
        Text(
          inputTextValue,
          style: TextStyle(fontSize: 30),
        ),
        TextButton(
          child: Text('Another Form'),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return MoreForm();
              },
            ));
          },
        ),
      ],
    );
  }

  void addTextToColumn() {
    setState(() {
      print('value retrieved from text field is ${editingController.text}');
      inputTextValue = editingController.text;
      editingController.text = '';
    });
  }
}
