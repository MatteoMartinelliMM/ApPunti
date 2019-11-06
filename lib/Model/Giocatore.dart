import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';

import 'FirebaseConstans.dart';

class Giocatore {
  String name;
  String numero;
  int points;
  double pointDouble;
  Gioco gioco;

  Giocatore(this.name, this.points, this.pointDouble);

  Giocatore.newGiocatore(String name) {
    this.name = name;
    points = 0;
    this.pointDouble = 0.0;
  }

  @override
  bool operator ==(other) {
    return this.name == other.name;
  }

  Giocatore.fromSnapshot(DataSnapshot datasnaphot) {
    name = datasnaphot.value[NAME];
    numero = datasnaphot.value[NUMERO].toString();
  }
}
