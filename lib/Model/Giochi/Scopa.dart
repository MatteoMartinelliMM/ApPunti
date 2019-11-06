import 'package:firebase_database/firebase_database.dart';

import '../FirebaseConstans.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';

class Scopa extends Gioco {
  int _puntiFatti;

  Scopa.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _puntiFatti = datasnapshot.value[PUNTI_FATTI];
  }

  int get puntiFatti => _puntiFatti;

  set puntiFatti(int value) {
    _puntiFatti = value;
  }
}
