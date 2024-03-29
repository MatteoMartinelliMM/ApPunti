import 'package:flutter/material.dart';
import 'package:flutter_app/Model/FirebaseDatabaseHelper.dart';
import 'package:flutter_app/Model/Giocatore.dart';
import 'package:flutter_app/Model/Giochi/ScoponeGioco.dart';

import '../Components/AvatarStack.dart';
import '../Components/CounterLayout.dart';
import '../Model/Constants.dart';
import 'BaseContaPunti.dart';

class ScoponeContaPunti extends StatefulWidget implements BaseContaPunti {
  int count1;
  int count2;
  bool p11, p21;
  Function callback;
  TextEditingController etC1 = new TextEditingController();
  TextEditingController etC2 = new TextEditingController();

  ScoponeContaPuntiState scoponeState;

  bool isScopone;

  String gioco;

  ScoponeContaPunti(this.giocatori, this.callback,this.gioco, this.isScopone) {
    p11 = false;
    p21 = true;
    count1 = 0;
    count2 = 0;
    etC1.text = count1.toString();
    count2 = 0;
    etC2.text = count2.toString();
  }

  @override
  State<StatefulWidget> createState() {
    return ScoponeContaPuntiState();
  }

  @override
  bool calcolaVittoria() {
    if (isScopone) {
      if (p21 && (count1 > 21 || count2 > 21)) return true;
      if (p11 && (count1 > 11 || count2 > 11)) return true;
      return false;
    } else {
      return count1 > 0 || count2 > 0;
    }
  }

  @override
  List<Giocatore> giocatori;

  @override
  void updatePartita() {
    FirebaseDatabaseHelper fbDbH = new FirebaseDatabaseHelper();
    for (Giocatore g in giocatori) {
      g.gioco.partiteGiocate++;
      if (giocatori.indexOf(g) <= 1) {
        if (count1 > count2) g.gioco.partiteVinte++;
        ScoponeGioco gioco = g.gioco as ScoponeGioco;
        gioco.puntiFatti += count1;
        g.gioco = gioco;
      } else {
        if (count1 < count2) g.gioco.partiteVinte++;
        ScoponeGioco gioco = g.gioco as ScoponeGioco;
        gioco.puntiFatti += count2;
        g.gioco = gioco;
      }
    }
    fbDbH.updateGioco(giocatori, gioco);
  }
}

class ScoponeContaPuntiState extends State<ScoponeContaPunti> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Opacity(
                opacity: widget.isScopone ? 1.0 : 0.0,
                child: Align(
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
                              value: widget.p11,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.p11 = value;
                                  widget.p21 = !value;
                                  if (widget.calcolaVittoria())
                                    widget.callback();
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
                              value: widget.p21,
                              onChanged: (bool value) {
                                setState(() {
                                  widget.p21 = value;
                                  widget.p11 = !value;
                                  if (widget.calcolaVittoria())
                                    widget.callback();
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
                            child: CounterLayout.defaultLayout(widget.etC1, () {
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
                              widget.giocatori[0].name,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 15, bottom: 8.0),
                            child: Text(widget.giocatori[1].name,
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
                          child: CounterLayout.defaultLayout(widget.etC2, () {
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
                            widget.giocatori[2].name,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 8.0, left: 15, bottom: 8.0),
                          child: Text(widget.giocatori[3].name,
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
      widget.count1++;
      widget.etC1.text = widget.count1.toString();
      if (widget.calcolaVittoria()) widget.callback();
    });
  }

  void decrementCounterTeam1() {
    setState(() {
      if (widget.count1 > 0) {
        widget.count1--;
        widget.etC1.text = widget.count1.toString();
        widget.callback();
      }
    });
  }

  void onTextChangeTeam1() {
    setState(() {
      widget.count1 = int.parse(widget.etC1.text);
      widget.callback();
    });
  }

  void incrementCounterTeam2() {
    setState(() {
      widget.count2++;
      widget.etC2.text = widget.count2.toString();
      if (widget.calcolaVittoria()) widget.callback();
    });
  }

  void decrementCounterTeam2() {
    setState(() {
      if (widget.count2 > 0) {
        widget.count2--;
        widget.etC2.text = widget.count2.toString();
        widget.callback();
      }
    });
  }

  void onTextChangeTeam2() {
    setState(() {
      widget.count2 = int.parse(widget.etC2.text);
      widget.callback();
    });
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
