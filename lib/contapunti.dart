import 'package:flutter/material.dart';
import 'package:flutter_app/Components/avatarstack.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'Components/CounterLayout.dart';

class ContaPuntiGiocatori extends StatefulWidget {
  List<Giocatore> giocatori;

  String gioco;

  ContaPuntiGiocatori(this.giocatori, this.gioco);

  @override
  State<StatefulWidget> createState() {
    return new ContaPuntiGiocatoriState(giocatori, gioco);
  }
}

class ContaPuntiGiocatoriState extends State<ContaPuntiGiocatori> {
  List<Giocatore> giocatori;

  String gioco;
  int count1;

  ContaPuntiGiocatoriState(this.giocatori, this.gioco);

  TextEditingController etC = new TextEditingController();

  @override
  void initState() {
    count1 = 0;
    etC.text = count1.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gioco)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: stackavatar(getImageName(), 80.0, 80.0),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: CounterLayout.defaultLayout(etC, () {
                          decrementCounter();
                        }, () {
                          incrementCounter();
                        }, () {
                          onTextChange();
                        }),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(name)
          ],
        ),
      ),
    );
  }

  void incrementCounter() {
    setState(() {
      count1++;
      etC.text = count1.toString();
    });
  }

  void decrementCounter() {
    setState(() {
      if (count1 > 0) {
        count1--;
        etC.text = count1.toString();
      }
    });
  }

  void onTextChange() {
    count1 = int.parse(etC.text);
  }

  List<String> getImageName() {
    List<String> imageName = new List();
    /*for(Giocatore g in giocatori)
      imageName.add(g.name);
    return imageName;*/
    imageName.add(IMAGE_PATH + "scanse.jpg");
    imageName.add(IMAGE_PATH + "vale.jpg");
    return imageName;
  }
}

String getValue(List<Giocatore> giocatori) {
  String g = "";
  for (Giocatore gi in giocatori) {
    g += gi.name + " ";
  }
  return g;
}
