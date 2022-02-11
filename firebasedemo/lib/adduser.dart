import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddUser extends StatefulWidget {
  AddUser();

  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  @override
  Widget build(BuildContext context) {
    //use this form key to handle anything related to forms
    final _formKey = GlobalKey<FormState>();
    //this is to handle the firstname text form field
    final myController1 = TextEditingController();
    //this is the to handle the lastname text form field
    final myController2 = TextEditingController();

    Stream<QuerySnapshot>? collectionStream;
    List<HPCharacter> hpCharacters = [];

    //this is where we initialise and get the data if need be.

    Future<DocumentSnapshot> getData() async {
      //DO NOT SKIP THIS, else it wont work.
      //you HAVE to initialize the firebase app first
      await Firebase.initializeApp();
      print('Initialized the Firebase App');
      //initialize the stream so that whenever there is a change
      //this stream will be notified of it
      collectionStream =
          FirebaseFirestore.instance.collection('hpcharacters').snapshots();
      //if you have any authentication, you have to do it here
      //this is an example of how to do it anonymously.
      //for this to work, you should have set the authentication in your
      //firebase project
      await FirebaseAuth.instance.signInAnonymously();
      //To get the data using a QUERY SNAPSHOT instead of DOCUMENT SNAPSHOT
      //here we are getting all the documents
      FirebaseFirestore.instance
          .collection('hpcharacters')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((doc) {
          hpCharacters
              .add(HPCharacter(fname: doc['fname'], lname: doc['lname']));
        });
      });
      //here we are trying to get a specific document
      return await FirebaseFirestore.instance
          .collection('hpcharacters')
          .doc('rZMSDiE2k9hyA4fUkyuP')
          .get()
          .then((DocumentSnapshot value) {
        return value;
      });
    }

    //FutureBuilder is used to create the UI asynchronously based on
    //the state of the connection
    return FutureBuilder(
      // Initialize FlutterFire
      future: getData(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          print('HAS ERROR');
          return Container(
            child: Center(
              child: Text('Error encountered during connection'),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          print('CONNECTION DONE');
          CollectionReference users =
              FirebaseFirestore.instance.collection('hpcharacters');
          //function to add the newly entered HP character to the FIREBASE
          //database and let the users know if it was done or not
          Future<void> addCharacter() {
            print('comes to addCharacter');
            print(myController1.text);
            print(myController2.text);
            // Call the user's CollectionReference to add a new user
            return users
                .add({
                  'fname': myController1.text, // John Doe
                  'lname': myController2.text, // Stokes and Sons
                })
                .then((value) => print(value))
                .catchError(
                    (error) => print("Failed to add character: $error"));
          }

          //Method to use the collection stream to check and build the list
          //of characters present in the firebase backend.
          Widget getHPCharacters(BuildContext context) {
            return StreamBuilder<QuerySnapshot>(
              stream: collectionStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loading");
                }

                return Expanded(
                  child: ListView(
                    children: snapshot.data!.docs.map(
                      (DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return ListTile(
                          title: Text(data['fname']),
                          subtitle: Text(data['lname']),
                        );
                      },
                    ).toList(),
                  ),
                );
              },
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: Text('Adding HP Characters to Firebase'),
            ),
            body: Column(
              children: [
                Form(
                  key: _formKey, //you can use this to add check
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Enter First Name: '),
                          Expanded(
                            child: TextFormField(
                              controller: myController1,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text('Enter Last Name: '),
                          Expanded(
                            child: TextFormField(
                              controller: myController2,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: addCharacter,
                        child: Text(
                          "Add HP Character",
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(),
                Center(
                  child: Text('Existing List of HP Characters'),
                ),
                //we are going to ensure that the data added to the backend is
                //reflected in the list by using the stream.
                getHPCharacters(context),
                //if you dont want to stream the data from backend, you can
                //create your own data by adding it to the list as and when
                //you add.
                // Expanded(
                //   child: ListView.builder(
                //       itemCount: hpCharacters.length,
                //       itemBuilder: (context, index) {
                //         return ListTile(
                //           title: Text(hpCharacters[index].fname),
                //           leading: Text(hpCharacters[index].lname),
                //         );
                //       }),
                // ),
              ],
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        print('WAITING...');
        return Container(
          child: Center(
            child: Text('Still Processing...'),
          ),
        );
      },
    );
  }
}

class HPCharacter {
  String fname = '';
  String lname = '';
  HPCharacter({required this.fname, required this.lname});

  @override
  String toString() {
    return 'First name : $fname and Last name : $lname';
  }
}
