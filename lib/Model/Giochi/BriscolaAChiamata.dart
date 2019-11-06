import 'package:firebase_database/firebase_database.dart';

import 'package:flutter_app/Model/Giochi/Gioco.dart';

import '../FirebaseConstans.dart';

class BriscolaAChiamata extends Gioco{
  double _puntiFatti;

  BriscolaAChiamata.fromSnapshot(DataSnapshot datasnapshot) : super.fromSnapshot(datasnapshot){
    _puntiFatti = datasnapshot.value[PUNTI_FATTI];
  }

  double get puntiFatti => _puntiFatti;

  set puntiFatti(double value) {
    _puntiFatti = value;
  }


}