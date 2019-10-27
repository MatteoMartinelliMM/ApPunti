import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'BaseContaPunti.dart';
import '../Components/CounterLayout.dart';
import '../Components/AvatarStack.dart';
import '../Model/Constants.dart';

class ScoponeContaPunti extends StatefulWidget implements BaseContaPunti {
  int count1;
  int count2;
  bool p11, p21;
  Function callback;
  TextEditingController etC1 = new TextEditingController();
  TextEditingController etC2 = new TextEditingController();

  ScoponeContaPuntiState scoponeState;

  ScoponeContaPunti(this.giocatori, this.callback) {
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
    if (p21 && (count1 > 21 || count2 > 21)) return true;
    if (p11 && (count1 > 11 || count2 > 11)) return true;
    return false;
  }

  @override
  List<Giocatore> giocatori;
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
                            value: widget.p11,
                            onChanged: (bool value) {
                              setState(() {
                                widget.p11 = value;
                                widget.p21 = !value;
                                if (widget.calcolaVittoria()) widget.callback();
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
                                if (widget.calcolaVittoria()) widget.callback();
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
        if (widget.calcolaVittoria()) widget.callback();
      }
    });
  }

  void onTextChangeTeam1() {
    setState(() {
      widget.count1 = int.parse(widget.etC1.text);
      if (widget.calcolaVittoria()) widget.callback();
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
        if (widget.calcolaVittoria()) widget.callback();
      }
    });
  }

  void onTextChangeTeam2() {
    setState(() {
      widget.count2 = int.parse(widget.etC2.text);
      if (widget.calcolaVittoria()) widget.callback();
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
