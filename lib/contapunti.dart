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
  int count2;
  bool p11, p21;

  ContaPuntiGiocatoriState(this.giocatori, this.gioco);

  TextEditingController etC1 = new TextEditingController();
  TextEditingController etC2 = new TextEditingController();

  @override
  void initState() {
    count1 = 0;
    etC1.text = count1.toString();
    count2 = 0;
    etC2.text = count2.toString();
    p11 = false;
    p21 = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gioco)),
      floatingActionButton: Visibility(
          visible: true, //TODO REPLACE WITH LOGIC
          child: FloatingActionButton(
            onPressed: null,
            child: Icon(Icons.save),
          )),
      body: Column(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text("Punti vittoria",
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: p11,
                            onChanged: (bool value) {
                              setState(() {
                                p11 = value;
                                p21 = !value;
                              });
                            },
                          ),
                          Text("11 punti")
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Checkbox(
                            value: p21,
                            onChanged: (bool value) {
                              setState(() {
                                p21 = value;
                                p11 = !value;
                              });
                            },
                          ),
                          Text("21 punti")
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Card(
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
                            child: CounterLayout.defaultLayout(etC1, () {
                              decrementCounterTeam1();
                            }, () {
                              incrementCounterTeam1();
                            }, () {
                              onTextChangeTeam1();
                            }),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 15, bottom: 8.0),
                            child: Text(
                              giocatori[0].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 15, bottom: 8.0),
                            child: Text(giocatori[1].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 18)),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Image.asset('assets/image/vs_small.png'),
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
                          child: CounterLayout.defaultLayout(etC2, () {
                            decrementCounterTeam2();
                          }, () {
                            incrementCounterTeam2();
                          }, () {
                            onTextChangeTeam2();
                          }),
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 15, bottom: 8.0),
                          child: Text(
                            giocatori[2].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 15, bottom: 8.0),
                          child: Text(giocatori[3].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void incrementCounterTeam1() {
    setState(() {
      count1++;
      etC1.text = count1.toString();
    });
  }

  void decrementCounterTeam1() {
    setState(() {
      if (count1 > 0) {
        count1--;
        etC1.text = count1.toString();
      }
    });
  }

  void onTextChangeTeam1() {
    count1 = int.parse(etC1.text);
  }

  void incrementCounterTeam2() {
    setState(() {
      count2++;
      etC2.text = count2.toString();
    });
  }

  void decrementCounterTeam2() {
    setState(() {
      if (count2 > 0) {
        count2--;
        etC2.text = count2.toString();
      }
    });
  }

  void onTextChangeTeam2() {
    count2 = int.parse(etC2.text);
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
