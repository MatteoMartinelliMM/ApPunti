import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'BaseAggiungiGiocatori.dart';

class AggiungiGiocatoriScopa extends StatefulWidget
    implements BaseAggiungiGiocatori {
  VoidCallback callback;
  List<Giocatore> giocatori;
  String gioco;
  String howmanyPlayer;
  List<String> nrOfPlayer;

  AggiungiGiocatoriScopa(this.giocatori, this.gioco, this.callback);

  @override
  State<StatefulWidget> createState() {
    return new AggiungiGIocatoriScopaState();
  }

  @override
  bool canGoNext() {
    return false;
  }

  @override
  List<Giocatore> onFabClick() {
    // TODO: implement onFabClick
    return null;
  }
}

class AggiungiGIocatoriScopaState extends State<AggiungiGiocatoriScopa> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Align(
                alignment: Alignment.topCenter,
                child: DropdownButton<String>(
                    value: widget.howmanyPlayer,
                    isExpanded: true,
                    items: widget.nrOfPlayer.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        widget.howmanyPlayer = value;
                      });
                    })),
          ),
          Expanded(child: Align(alignment: Alignment.center, child: getBody()))
        ],
      ),
    );
  }

  @override
  void initState() {
    widget.nrOfPlayer = new List();
    widget.nrOfPlayer.add(DUO);
    widget.nrOfPlayer.add(TLE);
    if (widget.gioco != CIRULLA) {
      widget.nrOfPlayer.add(QUATLO);
    }
    widget.howmanyPlayer = widget.nrOfPlayer[0];
  }

  Widget getBody() {
    switch (widget.howmanyPlayer) {
      case DUO:
        return duo();
      case TLE:
        return tle();
      case QUATLO:
        break;
    }
    return tle();
  }

  Widget tle() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          IMAGE_PATH + 'defuser.png'))),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 3,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          IMAGE_PATH + 'defuser.png'))),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Image.asset(IMAGE_PATH + 'vs_small.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(flex: 2,),
              Flexible(
                flex: 3,
                child: Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          IMAGE_PATH + 'defuser.png'))),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(flex: 2,),
            ],
          )
        ],
      ),
    );
  }

  Widget duo() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        IMAGE_PATH + 'defuser.png'))),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Image.asset(IMAGE_PATH + 'vs_small.png'),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        IMAGE_PATH + 'defuser.png'))),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
