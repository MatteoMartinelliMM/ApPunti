import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';

import 'FirebaseConstans.dart';

class Giocatore {
  String name;
  String numero;
  String url;
  bool darkMode;
  Gioco gioco;
  List<Gioco> giochi;

  Giocatore(this.name) {
    url = '';
    numero = '';
    gioco = null;
  }

  Giocatore.newGiocatore(String name) {
    this.name = name;
    this.url = '';
  }

  Giocatore.fromDbMap(Map<String, dynamic> result) {
    name = result[NAME];
    numero = result[NUMERO];
    url = result[URL];
    int darkMode = result[DARK_MODE];
    this.darkMode = darkMode == 1;
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

  Giocatore.newGiocatoreForFB(String name, String numero) {
    this.name = name;
    this.numero = numero;
    url = '';
  }

  Giocatore.fromFirebaseMap(Map giocatoreMap) {
    name = giocatoreMap[NAME];
    numero = giocatoreMap[NUMERO].toString();
    url = giocatoreMap[URL];
  }

  Map<String, String> giocatoreAsFirebaseMap() {
    Map<String, String> map = new Map();
    map[NAME] = name;
    map[NUMERO] = numero;
    map[URL] = url;
    return map;
  }

  Map<String, dynamic> darkModeAsMap() {
    Map<String, dynamic> map = new Map();
    map[DARK_MODE] = darkMode ? 1 : 0;
    return map;
  }

  Map<String, dynamic> giocatoreAsDbMap() {
    Map<String, dynamic> map = new Map();
    map[NAME] = name;
    map[NUMERO] = numero;
    map[URL] = url;
    map[DARK_MODE] = false;
    return map;
  }
}
