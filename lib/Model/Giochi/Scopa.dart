import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';

import '../FirebaseConstans.dart';

class Scopa extends Gioco {
  int _puntiFatti;

  Scopa.giocoForFb() : super.giocoForFb() {
    _puntiFatti = 0;
  }

  Scopa.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _puntiFatti = datasnapshot.value[PUNTI_FATTI];
  }

  Scopa.fromDbMap(Map<String, dynamic> map) : super.fromDbMap(map) {
    _puntiFatti = map[PUNTI_FATTI];
  }

  int get puntiFatti => _puntiFatti;

  set puntiFatti(int value) {
    _puntiFatti = value;
  }

  @override
  Map<String, int> asMap() {
    Map<String, int> asMap = super.asMap();
    asMap[PUNTI_FATTI] = _puntiFatti;
    return asMap;
  }

  Map<String, dynamic> asDbMap() {
    Map<String, dynamic> map = super.asDbMap();
    map[PUNTI_FATTI] = puntiFatti;
    return map;
  }

}
