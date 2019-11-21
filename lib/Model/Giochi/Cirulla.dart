import 'package:firebase_database/firebase_database.dart';

import '../FirebaseConstans.dart';
import 'Gioco.dart';

class Cirulla extends Gioco {
  int _puntiFatti;

  Cirulla.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _puntiFatti = datasnapshot.value[PUNTI_FATTI];
  }

  Cirulla.fromDbMap(Map<String, dynamic> map) : super.fromDbMap(map) {
    _puntiFatti = map[PUNTI_FATTI];
  }

  Cirulla.giocoForFb() : super.giocoForFb() {
    _puntiFatti = 0;
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
    map[GIOCO] = map[PARTITE_GIOCATE] = partiteGiocate;
    map[PARTITE_VINTE] = partiteVinte;
    map[PUNTI_FATTI] = puntiFatti;
    return map;
  }
}
