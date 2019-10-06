import 'package:flutter/material.dart';

void main() => runApp(Prova());

class Prova extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Prova',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(title: new Text("bo")),
        body: Align(
          alignment: Alignment.center,
          child: Custom('Dio'),
        ));
  }
}

class Custom extends StatelessWidget {
  String text;
  int count;

  Custom(String s) {
    text = s;
    count = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        height: 56.0,
        width: 56.0,
        margin: EdgeInsets.only(bottom: 8.0),
        decoration: new BoxDecoration(color: Colors.cyanAccent),
        child: Align(
            alignment: Alignment.center,
            child: Text(
              fillValue(text),
              style: new TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            )),
      ),
      Container(
          height: 56.0,
          width: 56.0,
          decoration: new BoxDecoration(color: Colors.cyanAccent),
          child: Align(
            alignment: Alignment.center,
            child: Text(fillValue(text),
                style: new TextStyle(color: Colors.white)),
          )),
    ]);
  }

  String fillValue(String s) {
    if (count == 0) {
      count++;
      return s.toUpperCase();
    } else {
      String toReturn;
      toReturn = s + " " + "$count";
      count++;
      return toReturn.toUpperCase();
    }
  }
}
