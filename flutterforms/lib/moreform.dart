import 'package:flutter/material.dart';
import 'package:flutterforms/fluttersteps.dart';

enum SearchType { web, image, news, shopping }

class MoreForm extends StatelessWidget {
  const MoreForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Text('More Form Widgets'),
        ),
        body: ProperForm(),
      ),
    );
  }
}

// This is a stateful widget. Don't worry about how it or
// the setState() calls work until
class ProperForm extends StatefulWidget {
  @override
  _ProperFormState createState() => _ProperFormState();
}

class _ProperFormState extends State<ProperForm> {
// A Map (aka. hash) to hold the data from the Form.
  final Map<String, dynamic> _searchForm = <String, dynamic>{
    'searchTerm': '',
    'searchType': SearchType.web,
    'safeSearchOn': true,
  };
// The Flutter key to point to the Form
  final GlobalKey<FormState> _key = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
// Make autovalidate true to validate on every keystroke. In
// this case we only want to validate on submit.
      autovalidateMode: AutovalidateMode.disabled,
      child: Container(
        child: ListView(
          children: [
            TextFormField(
              initialValue: _searchForm['searchTerm'],
              decoration: InputDecoration(
                labelText: 'Search terms',
              ),
// On every keystroke, you can do something.
              onChanged: (String val) {
                setState(() => _searchForm['searchTerm'] = val);
              },
// When the user submits, you could do something
// for this field
              onSaved: (val) {
                print('OnSaved of TextFormField');
              },
//Called when we "validate()". The val is the String
// in the text box.
//Note that it returns a String; null if validation passes
// and an error message if it fails for some reason.
              validator: (val) {
                print('Validator of TextFormField');
                if (val!.isEmpty) {
                  return 'We need something to search for';
                }
                return null;
              },
            ),
            FormField<SearchType>(
              builder: (FormFieldState<SearchType> state) {
                return DropdownButton<SearchType>(
                  value: _searchForm['searchType'],
                  items: const <DropdownMenuItem<SearchType>>[
                    DropdownMenuItem<SearchType>(
                      child: Text('Web'),
                      value: SearchType.web,
                    ),
                    DropdownMenuItem<SearchType>(
                      child: Text('Image'),
                      value: SearchType.image,
                    ),
                    DropdownMenuItem<SearchType>(
                      child: Text('News'),
                      value: SearchType.news,
                    ),
                    DropdownMenuItem<SearchType>(
                      child: Text('Shopping'),
                      value: SearchType.shopping,
                    ),
                  ],
                  onChanged: (val) {
                    setState(() => _searchForm['searchType'] = val);
                  },
                );
              },
              onSaved: (initialValue) {
                print('OnSaved of DropDownButton');
              },
            ),
// Wrapping the Checkbox in a FormField so we can have an
// onSaved and a validator
            FormField<bool>(
//initialValue: false, // Ignored for Checkboxes
              builder: (FormFieldState<bool> state) {
                return Row(
                  children: <Widget>[
                    Checkbox(
                      value: _searchForm['safeSearchOn'],
// Every time it changes, you can do something.
                      onChanged: (val) {
                        setState(() => _searchForm['safeSearchOn'] = val);
                      },
                    ),
                    const Text('Safesearch on'),
                  ],
                );
              },
// When the user saves, this is run
              onSaved: (initialValue) {
                print('OnSaved of CheckBox');
              },
// No need for validation because it is a checkbox. But
// if you wanted it, put a validator function here.
            ),
// This is the 'Submit' button
            ElevatedButton(
              child: const Text('Submit'),
              onPressed: () {
// If every field passes validation, let them through.
// Remember, this calls the validator on all fields in
// the form.
                if (_key.currentState!.validate()) {
// Similarly this calls onSaved() for all fields
                  _key.currentState!.save();
// You'd save the data to a database or whatever here
                  print(
                      'Value for searchTerm set as ${_searchForm['searchTerm']}');
                  print(
                      'Value for searchType set as ${_searchForm['searchType']}');
                  print(
                      'Value for safeSearchOn set as ${_searchForm['safeSearchOn']}');
                  print('Successfully saved the state.');
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return StepperApp();
                    },
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
