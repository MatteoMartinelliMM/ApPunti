import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';

import '../FirebaseConstans.dart';

class BriscolaAChiamata extends Gioco {
  double _puntiFatti;

  BriscolaAChiamata.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _puntiFatti = datasnapshot.value[PUNTI_FATTI];
  }

  BriscolaAChiamata.giocoForFb() : super.giocoForFb() {
    _puntiFatti = 0.0;
  }

  BriscolaAChiamata.fromDbMap(Map<String, dynamic> map) : super.fromDbMap(map) {
    _puntiFatti = map[PUNTI_FATTI];
  }

  double get puntiFatti => _puntiFatti;

  set puntiFatti(double value) {
    _puntiFatti = value;
  }

  Map<String, double> asMapBriscolaAChiamata() {
    Map<String, double> asMap = new Map();
    asMap[PARTITE_GIOCATE] = partiteGiocate.toDouble();
    asMap[PARTITE_VINTE] = partiteVinte.toDouble();
    asMap[PUNTI_FATTI] = puntiFatti;
    return asMap;
  }

  Map<String, dynamic> asDbMap() {
    Map<String, dynamic> map = super.asDbMap();
    map[PARTITE_GIOCATE] = partiteGiocate;
    map[PARTITE_VINTE] = partiteVinte;
    map[PUNTI_FATTI_BR] = puntiFatti;
    return map;
  }
}
