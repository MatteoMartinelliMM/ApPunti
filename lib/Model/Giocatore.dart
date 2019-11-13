import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';

import 'FirebaseConstans.dart';

class Giocatore {
  String name;
  String numero;
  String url;
  int points;
  double pointDouble;
  Gioco gioco;

  Giocatore(this.name, this.points, this.pointDouble);

  Giocatore.newGiocatore(String name) {
    this.name = name;
    points = 0;
    this.pointDouble = 0.0;
    this.url = '';
  }

  @override
  bool operator ==(other) {
    return this.name == other.name;
  }

  Giocatore.fromSnapshot(DataSnapshot datasnaphot) {
    name = datasnaphot.value[NAME];
    numero = datasnaphot.value[NUMERO].toString();
    url = datasnaphot.value[URL];
  }

  Giocatore.fromMap(Map datasnaphot) {
    name = datasnaphot[NAME];
    numero = datasnaphot[NUMERO].toString();
    url = datasnaphot[URL];
  }

  Giocatore.newGiocatoreForFB(String name, String numero) {
    this.name = name;
    this.numero = numero;
    url = '';
  }

  Map<String, String> giocatoreAsMap() {
    Map<String, String> map = new Map();
    map[NAME] = name;
    map[NUMERO] = numero;
    map[URL] = url;
    return map;
  }
}
