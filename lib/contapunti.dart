import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Giocatore.dart';

class ContaPuntiGiocatori extends StatefulWidget {
  List<Giocatore> giocatori;

  String gioco;

  ContaPuntiGiocatori(this.giocatori, this.gioco);

  @override
  State<StatefulWidget> createState() {
    return new ContaPuntiGiocatoriState(giocatori,gioco);
  }
}

class ContaPuntiGiocatoriState extends State<ContaPuntiGiocatori> {
  List<Giocatore> giocatori;

  String gioco;

  ContaPuntiGiocatoriState(this.giocatori, this.gioco);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gioco)),
      body: Text(getValue(giocatori)),
    );
  }
}

String getValue(List<Giocatore> giocatori) {
  String g = "";
  for (Giocatore gi in giocatori) {
    g += gi.name + " ";
  }
  return g;
}
