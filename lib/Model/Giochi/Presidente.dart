import 'package:firebase_database/firebase_database.dart';

import '../FirebaseConstans.dart';
import 'Gioco.dart';

class Presidente extends Gioco {
  int _schiavo;

  Presidente.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot) {
    _schiavo = datasnapshot.value[SCHIAVO];
  }

  Presidente.giocoForFb() : super.giocoForFb() {
    _schiavo = 0;
  }

  Presidente.fromDbMap(Map<String, dynamic> map) : super.fromDbMap(map) {
    _schiavo = map[SCHIAVO];
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


}
