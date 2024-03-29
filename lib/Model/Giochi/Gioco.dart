import 'package:firebase_database/firebase_database.dart';

import '../FirebaseConstans.dart';

abstract class Gioco {
  int _partiteGiocate;

  int _partiteVinte;

  int get partiteGiocate => _partiteGiocate;

  Gioco.giocoForFb() {
    _partiteGiocate = 0;
    _partiteVinte = 0;
  }

  Gioco.fromSnapshot(DataSnapshot datasnapshot) {
    _partiteGiocate = datasnapshot.value[PARTITE_GIOCATE];
    _partiteVinte = datasnapshot.value[PARTITE_VINTE];
  }

  Gioco.fromDynamicMap(Map<dynamic, dynamic> map) {
    _partiteGiocate = map[PARTITE_GIOCATE];
    _partiteVinte = map[PARTITE_VINTE];
  }

  set partiteGiocate(int value) {
    _partiteGiocate = value;
  }

  int get partiteVinte => _partiteVinte;

  set partiteVinte(int value) {
    _partiteVinte = value;
  }

  Map<String, int> asMap() {
    Map<String, int> values = new Map();
    values[PARTITE_GIOCATE] = _partiteGiocate;
    values[PARTITE_VINTE] = _partiteVinte;
    return values;
  }

  Map<String, double> asMapBriscolaAChiamata() {
    return new Map();
  }

  Map<String, dynamic> asDbMap() {
    Map<String, dynamic> values = new Map();
    values[GIOCO] = runtimeType.toString();
    values[PARTITE_GIOCATE] = _partiteGiocate;
    values[PARTITE_VINTE] = _partiteVinte;
    return values;
  }

  Gioco.fromDbMap(Map<String, dynamic> map) {
    _partiteGiocate = map[PARTITE_GIOCATE];
    _partiteVinte = map[PARTITE_VINTE];
  }
}
