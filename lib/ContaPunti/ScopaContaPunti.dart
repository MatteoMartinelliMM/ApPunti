import 'package:flutter/material.dart';
import 'package:flutter_app/ContaPunti/BaseContaPunti.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

class ScopaContaPunti extends StatefulWidget implements BaseContaPunti {
  List<Giocatore> giocatori;

  VoidCallback callback;

  String gioco;
  int count1, count2;

  bool p21;
  bool p11;

  ScopaContaPunti(this.giocatori, this.gioco, this.callback) {
    this.count1 = 0;
    this.count2 = 0;
    p21 = true;
    p11 = true;
  }

  @override
  State<StatefulWidget> createState() {
    return new ScopaContaPuntiState();
  }

  @override
  bool calcolaVittoria() {
    switch (gioco) {
      case SCOPA:
        if (p21 && (count1 > 21 || count2 > 21)) return true;
        if (p11 && (count1 > 11 || count2 > 11)) return true;
        return false;
      case CIRULLA:
        return false;
      case BRISCOLA:
        return count1 > 0 || count2 > 0;
    }
  }
}

class ScopaContaPuntiState extends State<ScopaContaPunti> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
