void main() {
  mainasync();
}

void mainfuture() {
  print('A');
  futurePrint(Duration(milliseconds: 1), 'B').then((status) => print(status));
  print('C');
  futurePrint(Duration(milliseconds: 2), 'D').then((status) => print(status));
  print('E');
}

Future<String> futurePrint(Duration dur, String msg) {
  return Future.delayed(dur).then((onValue) => msg);
}

void mainasync() async {
  print('A');
  await futurePrint(Duration(milliseconds: 1), 'B')
      .then((status) => print(status));
  print('C');
  await futurePrint(Duration(milliseconds: 2), 'D')
      .then((status) => print(status));
  print('E');
}
