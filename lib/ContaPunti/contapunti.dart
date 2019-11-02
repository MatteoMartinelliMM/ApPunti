import 'package:flutter/material.dart';
import 'package:flutter_app/ContaPunti/PresidenteContaPunti.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'BaseContaPunti.dart';
import 'BriscolaAChiamataContaPunti.dart';
import 'ScopaContaPunti.dart';
import 'ScoponeContaPunti.dart';

class ContaPuntiGiocatori extends StatefulWidget {
  List<Giocatore> giocatori;

  String gioco;
  BaseContaPunti contaPunti;

  ContaPuntiGiocatori(this.giocatori, this.gioco);

  @override
  State<StatefulWidget> createState() {
    return new ContaPuntiGiocatoriState(giocatori, gioco);
  }
}

class ContaPuntiGiocatoriState extends State<ContaPuntiGiocatori> {
  List<Giocatore> giocatori;
  String gioco;

  Widget w;
  ObjectKey key;

  ContaPuntiGiocatoriState(this.giocatori, this.gioco);

  TextEditingController etC1 = new TextEditingController();
  TextEditingController etC2 = new TextEditingController();

  @override
  void initState() {
    w = getContaPuntiLayout(gioco);
    widget.contaPunti = (w) as BaseContaPunti;
    key = new ObjectKey(widget.contaPunti);
  }

  @override
  Widget build(BuildContext context) {
    widget.contaPunti = key.value;
    return Scaffold(
      appBar: AppBar(title: Text(gioco)),
      floatingActionButton: Visibility(
          visible: widget.contaPunti.calcolaVittoria(),
          child: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return rigiocaDialog();
                },
              );
              setState(() {
                initState();
              });
            },
            child: Icon(Icons.save),
          )),
      body: w,
    );
  }

  Widget getContaPuntiLayout(String gioco) {
    switch (gioco) {
      case SCOPA:
      case BRISCOLA:
      case CIRULLA:
        if (widget.giocatori.length == 4)
          return new ScoponeContaPunti(giocatori, callback, gioco == SCOPA);
        else
          return new ScopaContaPunti(giocatori, gioco, callback);
        break;
      case SCOPONE_SCIENTIFICO:
        return new ScoponeContaPunti(giocatori, callback, true);
      case BRISCOLA_A_CHIAMATA:
        return new BriscolaAChiamataContaPunti(giocatori, callback);
      case PRESIDENTE:
      case ASSE:
        return new PresidenteContaPunti(giocatori, gioco);
    }
  }

  void callback() {
    setState(() {});
  }

  Widget rigiocaDialog() {
    return AlertDialog(
      title: new Text("Vuoi giocare un'altra partita?"),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.popUntil(context, ModalRoute.withName('/'));
            },
            child: Text('No')),
        FlatButton(
          onPressed: () {
            setState(() {
              //TODO aggiorare dati db e firebase
              Navigator.of(context).pop();
              initState();
            });
          },
          child: Text("Si!"),
        )
      ],
    );
  }
}
