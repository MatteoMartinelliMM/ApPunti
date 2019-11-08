import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';

import '../FirebaseConstans.dart';

class BriscolaAChiamata extends Gioco {
  double _puntiFatti;

  BriscolaAChiamata.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _puntiFatti = datasnapshot.value[PUNTI_FATTI];
  }

  double get puntiFatti => _puntiFatti;

  set puntiFatti(double value) {
    _puntiFatti = value;
  }

  Map<String, double> asMapBriscolaAChiamata() {
    Map<String, double> asMap = new Map();
    asMap[PARTITE_GIOCATE] = partiteVinte as double;
    asMap[PARTITE_VINTE] = partiteGiocate as double;
    asMap[PUNTI_FATTI] = puntiFatti;
    return asMap;
  }
}
