import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Giocatore.dart';

class ContaPuntiGiocatori extends StatefulWidget {
  List<Giocatore> giocatori;

  ContaPuntiGiocatori(this.giocatori);

  @override
  State<StatefulWidget> createState() {
    return new ContaPuntiGiocatoriState(giocatori);
  }
}

class ContaPuntiGiocatoriState extends State<ContaPuntiGiocatori> {
  List<Giocatore> giocatori;

  ContaPuntiGiocatoriState(this.giocatori);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Conta punti')),
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
