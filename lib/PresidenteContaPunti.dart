import 'package:flutter/material.dart';
import 'package:flutter_app/BaseContaPunti.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'Model/Constants.dart';

class PresidenteContaPunti extends StatefulWidget implements BaseContaPunti {
  String gioco;

  List<Giocatore> giocatori;

  PresidenteContaPunti(this.giocatori, this.gioco);

  @override
  bool calcolaVittoria() {

  }

  @override
  State<StatefulWidget> createState() {
    return new PresidenteContaPuntiState();
  }
}

class PresidenteContaPuntiState extends State<PresidenteContaPunti> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
