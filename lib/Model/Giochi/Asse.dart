import 'package:firebase_database/firebase_database.dart';

import '../FirebaseConstans.dart';
import 'Gioco.dart';

class Asse extends Gioco {
  int _schiavo;

  Asse.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _schiavo = datasnapshot.value[SCHIAVO];
  }

  int get schiavo => _schiavo;

  set schiavo(int value) {
    _schiavo = value;
  }


}
