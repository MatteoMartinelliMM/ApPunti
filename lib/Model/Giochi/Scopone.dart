import 'package:firebase_database/firebase_database.dart';

import '../FirebaseConstans.dart';
import 'Gioco.dart';

class Scopone extends Gioco {
  int _puntiFatti;

  Scopone.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _puntiFatti = datasnapshot.value[PUNTI_FATTI];
  }

  int get puntiFatti => _puntiFatti;

  set puntiFatti(int value) {
    _puntiFatti = value;
  }
}
