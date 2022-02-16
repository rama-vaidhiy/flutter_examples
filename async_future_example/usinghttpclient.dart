import 'dart:convert';
import 'dart:io';

import 'supportingclasses.dart';

List<dynamic> userList = [];

void main() {
  print('Main call starts here');
  mainusingasync();
  print('Main call ends here');
}

void mainusingFuture() {
  print('mainusingFuture: Starting the program');
  var client = HttpClient();
  client
      .open('GET', 'jsonplaceholder.typicode.com', 80, '/users')
      .then((HttpClientRequest req) =>
          req.close().whenComplete(() => print('I have closed the connection')))
      .then((HttpClientResponse resp) =>
          resp.transform(utf8.decoder).listen((String data) {
            userList = jsonDecode(data);
            print('Data from Future List');
            for (var u in userList) {
              print('$u ***'); //Map<String,dynamic>
            }
          }))
      .whenComplete(() => print('I am done!'));
  print('mainusingFuture: Ending the program');
}

void mainusingasync() async {
  print('mainusingasync: Starting the program');
  var req = await HttpClient()
      .open('GET', 'jsonplaceholder.typicode.com', 80, '/users');
  var resp = await req.close();
  print('I closed the request');
  await for (var data in resp.transform(utf8.decoder)) {
    userList = jsonDecode(data);
    print('Data from Async List');
    for (var u in userList) {
      //Map<String, dynamic>
      //u['id']
      var myUser = User.fromJson(u);
      print(u);
      myUser.id = myUser.id + 100;
      print(myUser.toJson());
    }
  }
  print('I am done!');
  print('mainusingasync: Ending the program');
}
