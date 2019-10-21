import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'BaseContaPunti.dart';
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

  ContaPuntiGiocatoriState(this.giocatori, this.gioco);

  TextEditingController etC1 = new TextEditingController();
  TextEditingController etC2 = new TextEditingController();

  @override
  void initState() {
    w = getContaPuntiLayout(gioco);
    widget.contaPunti = (w) as BaseContaPunti;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gioco)),
      floatingActionButton: Visibility(
          visible: widget.contaPunti.calcolaVittoria(),
          child: FloatingActionButton(
            onPressed: () {
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
      case SCOPONE_SCIENTIFICO:
        return new ScoponeContaPunti(giocatori, callback);
    }
  }

  void callback() {
    setState(() {});
  }
}
