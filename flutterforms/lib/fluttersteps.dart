import 'package:flutter/material.dart';

class StepperApp extends StatefulWidget {
  StepperApp({Key? key}) : super(key: key);
  @override
  _StepperApp createState() => _StepperApp();
}

class _StepperApp extends State {
  var _currentStep = 0;
  //This is the object where the login details will be collected
  LoginData _loginData = new LoginData();
  //This is the form key which will hold the state of the form
  GlobalKey<FormState> _loginFormKey = new GlobalKey<FormState>();
  //this is the form key for the 2nd step
  GlobalKey<FormState> _dataFormKey = new GlobalKey<FormState>();
  //boolean to handle the validation
  bool _formValidation = false;
  bool _dataFormValidation = false;
  //more data from the 2nd step ..values stored here
  var _checkboxValue = false;
  var _switchValue = false;
  var _sliderValue = .3;
  var _radioValue = 1;

  //Focus node to ensure that the first element in the form
  //is automatically set to focus
  late FocusNode _loginFocusNode;
  late FocusNode _dataFocusNode;

  @override
  void initState() {
    super.initState();
    _loginFocusNode = FocusNode();
    _dataFocusNode = FocusNode();
  } //validate the form data and make sure to set

  //the boolean flag accordingly
  //this is called when we pres continue in the Stepper
  bool validateFormData() {
    //set the form validation to true by default that
    //will ensure that if the validation fails then it will
    //set to the autovalidation
    //but if the validation passes then we go to the next step
    _formValidation = true;
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      print("Username: ${_loginData.username}");
      print("Password: ${_loginData.password}");
      _formValidation = false;
      //once you are done with this step, and
      //we are going to the next one, we
      //can undo the focus on the login username field
      //and set the focus to the T & C checkbox in the next one
      //automatically.
      _loginFocusNode.unfocus();
      FocusScope.of(context).requestFocus(_dataFocusNode);
    }
    return _formValidation;
  }

  Future<bool?> _confirmAppExit() {
    print('starts the confirmAppExit');
    return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Exit App'),
            content: const Text('Are you sure you want to exit the app?'),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: const Text('Confirm'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }

  /**
   * Doing a similar thing as the Login Form Validation
   * for the data form but only for one element which is the
   * check box which is wrapped in a FormField at the moment
   */
  bool validateDataForm() {
    _dataFormValidation = true;
    if (_dataFormKey.currentState!.validate()) {
      print('Data form validation is successful');
      _dataFormKey.currentState!.save();
      _dataFormValidation = false;
    }
    return _dataFormValidation;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Flutter Form Playground")),
      body: Stepper(
        type: StepperType.vertical,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() {
              //if the currentStep is not 0 (form)
              //or if the currentStep is form and the
              //validation has passed successfully then
              //go to the next step.
              //else stay in the same step
              if (_currentStep == 0 && !validateFormData()) {
                _currentStep += 1;
              }
              if (_currentStep == 1 && !validateDataForm()) {
                _currentStep += 1;
              }
            });
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return DummyPage();
              },
            ));
            return null;
          }
        },
        onStepCancel: () {
          print(_currentStep);
          setState(() {
            if (_currentStep > 0)
              _currentStep -= 1;
            else if (_currentStep == 0) return null;
          });
        },
        steps: [
          Step(
            title: Text("Login"),
            isActive: true,
            //add the Form as the child of this step
            content: Form(
              onWillPop: () async {
                print('comes here to onWillPop');
                bool? result = await _confirmAppExit();
                if (result == null) {
                  result = false;
                }
                return result;
              },
              autovalidateMode: this._formValidation
                  ? AutovalidateMode.always
                  : AutovalidateMode.disabled,
              //associate it with the form key global state object
              key: this._loginFormKey,
              //add a child to the form which will have two fields
              //one for login and other for password
              child: Column(
                children: [
                  //login text form field
                  TextFormField(
                    autofocus: true,
                    //by associating the FocusNode to this
                    //field, we are ensuring that the control
                    //comes here automatically
                    focusNode: _loginFocusNode,
                    keyboardType: TextInputType.emailAddress,
                    //add an input decoration to ensure that you
                    //give hints to the user
                    decoration: InputDecoration(
                      hintText: 'abc@example.com',
                      labelText: 'Username (email address)',
                    ),
                    //add a validator to ensure that it is not empty
                    validator: (loginName) {
                      if (null == loginName || loginName.length == 0) {
                        return 'Please enter a username (email address)';
                      }
                      return null;
                    },
                    //what to do on save of the form? add a onSave function
                    onSaved: (loginName) {
                      //when we press submit , we should set the value of the
                      //login name to the Login object
                      this._loginData.username = loginName!;
                    },
                  ),
                  //password text form field
                  //repeat the same steps for password
                  //except to add an "obscure" property to it
                  //and set it to true (so that the password will not be
                  //visible)
                  TextFormField(
                    obscureText: true,
                    //this is just to show that you don't have to
                    //use the default * for obscuring your characters
                    //you can ignore this if you want to use * as your
                    //obscuring character
                    obscuringCharacter: '*',
                    keyboardType: TextInputType.visiblePassword,
                    //add an input decoration to ensure that you
                    //give hints to the user
                    decoration: InputDecoration(
                      hintText: 'anything but Password',
                      labelText: 'Password',
                    ),
                    //add a validator to ensure that it is not empty
                    validator: (password) {
                      if (null == password ||
                          password.length == 0 ||
                          password.length < 8) {
                        return 'Please enter a password which is at least 8 character long';
                      }
                      return null;
                    },
                    //what to do on save of the form? add a onSave function
                    onSaved: (password) {
                      //when we press submit , we should set the value of the
                      //password to the Login object
                      this._loginData.password = password!;
                    },
                  ),
                ],
              ),
            ),
          ),
          Step(
            title: Text("Add more Form Elements"),
            isActive: true,
            content: Form(
                key: this._dataFormKey,
                autovalidateMode: _dataFormValidation
                    ? AutovalidateMode.always
                    : AutovalidateMode.disabled,
                child: Column(children: [
                  //We can add the elements by themselves,
                  //but they wont get the formstate associated
                  //with them, so wrap them up in a formfield
                  FormField<bool>(
                    enabled: true,
                    builder: (state) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            children: [
                              Text('Agree to T&C?'),
                              Checkbox(
                                //this will receive the focus
                                //if we want to programmatically
                                //change the focus.
                                // focusNode: _dataFocusNode,
                                value: _checkboxValue,
                                onChanged: (value) {
                                  setState(() {
                                    _checkboxValue = value!;
                                    //you need to call this
                                    //to ensure that the
                                    //validator and onSave will
                                    //know that the value has been updated
                                    state.didChange(value);
                                  });
                                },
                              ),
                            ],
                          ),
                          Text(
                            //in order to get the error message
                            //because normal Checkbox doesnt have one
                            //we rely on the State object associated with the
                            //FormField to get the error message
                            //that is being set by the validator code.
                            state.errorText ?? '',
                            style:
                                TextStyle(color: Theme.of(context).errorColor),
                          ),
                        ],
                      );
                    },
                    validator: (value) {
                      if (value == null || !value) {
                        return 'You have to accept this';
                      }
                      return null;
                    },
                    onSaved: (newValue) =>
                        this._loginData.checkBoxValue = newValue!,
                  ),
                  //The following elements are left without
                  //wrapping them up in a FormField for you
                  //to see the difference in their behaviour
                  //They are part of a Form but not necessarily
                  //share the same state as the FormFields.
                  Row(
                    children: [
                      Text('Toggle on/off'),
                      Switch(
                          value: _switchValue,
                          onChanged: (bool inValue) {
                            setState(() {
                              _switchValue = inValue;
                            });
                          }),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Slider (0-20)'),
                      Slider(
                          min: 0,
                          max: 20,
                          value: _sliderValue,
                          onChanged: (inValue) {
                            setState(() => _sliderValue = inValue);
                          }),
                    ],
                  ),
                  Row(children: [
                    //you can also use RadioListTile if you want
                    Radio<int>(
                        value: 1,
                        groupValue: _radioValue,
                        onChanged: (inValue) {
                          setState(() {
                            _radioValue = inValue!;
                          });
                        }),
                    Text("Option 1")
                  ]),
                  Row(children: [
                    Radio<int>(
                        value: 2,
                        groupValue: _radioValue,
                        onChanged: (inValue) {
                          setState(() {
                            _radioValue = inValue!;
                          });
                        }),
                    Text("Option 2")
                  ]),
                  Row(children: [
                    Radio<int>(
                        focusNode: _dataFocusNode,
                        value: 3,
                        groupValue: _radioValue,
                        onChanged: (inValue) {
                          setState(() {
                            _radioValue = inValue!;
                          });
                        }),
                    Text("Option 3")
                  ])
                ])),
          ),
          Step(
            title: Text("Here are you form inputs"),
            isActive: true,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text('Your login data is ${_loginData.username}'),
                Text('Your T&C acceptance is ${_loginData.checkBoxValue}'),
                Text('Your toggle switch  data is ${_switchValue}'),
                Text('Your slider  data is ${_sliderValue}'),
                Text('Your radio data is ${_radioValue}'),
              ],
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _loginFocusNode.dispose();
    _dataFocusNode.dispose();
    super.dispose();
  }
}

class LoginData {
  String username = "";
  String password = "";
  bool checkBoxValue = false;
  bool toggleValue = false;
  int sliderValue = 0;
  int radioValue = 0;
}

class DummyPage extends StatelessWidget {
  const DummyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        child: Column(
          children: [
            Text('All Done! '),
            TextButton(
              child: Text('Go back'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
      ),
    );
  }
}
