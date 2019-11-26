import 'package:firebase_database/firebase_database.dart';

import '../FirebaseConstans.dart';
import 'Gioco.dart';

class Asse extends Gioco {
  int _schiavo;

  Asse.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _schiavo = datasnapshot.value[SCHIAVO];
  }

  Asse.giocoForFb() : super.giocoForFb() {
    _schiavo = 0;
  }

  int get schiavo => _schiavo;

  set schiavo(int value) {
    _schiavo = value;
  }

  @override
  Map<String, int> asMap() {
    Map<String, int> asMap = super.asMap();
    asMap[SCHIAVO] = _schiavo;
    return asMap;
  }

  Map<String, dynamic> asDbMap() {
    Map<String, dynamic> map = super.asDbMap();
    map[SCHIAVO] = schiavo;
    return map;
  }

  Asse.fromDbMap(Map<String, dynamic> map) : super.fromDbMap(map) {
    _schiavo = map[SCHIAVO];
  }
}
