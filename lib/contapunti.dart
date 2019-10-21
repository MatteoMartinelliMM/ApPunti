import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'BaseContaPunti.dart';
import 'ScoponeContaPunti.dart';

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
  BaseContaPunti contaPunti;
  String gioco;
  int count1;
  int count2;
  bool p11, p21;

  ContaPuntiGiocatoriState(this.giocatori, this.gioco);

  TextEditingController etC1 = new TextEditingController();
  TextEditingController etC2 = new TextEditingController();

  @override
  void initState() {
    switch (gioco) {
      case SCOPONE_SCIENTIFICO:
        contaPunti = new ScoponeContaPunti(giocatori);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gioco)),
      floatingActionButton: Visibility(
          visible: contaPunti.calcolaVittoria(),
          child: FloatingActionButton(
            onPressed: () {
              initState();
            },
            child: Icon(Icons.save),
          )),
      body: contaPunti,
    );
  }
}
