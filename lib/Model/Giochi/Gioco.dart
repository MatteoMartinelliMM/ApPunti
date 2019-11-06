import 'package:firebase_database/firebase_database.dart';

import '../FirebaseConstans.dart';

abstract class Gioco{
  int _partiteGiocate;

  int _partiteVinte;

  int get partiteGiocate => _partiteGiocate;

  Gioco.fromSnapshot(DataSnapshot datasnapshot){
    _partiteGiocate = datasnapshot.value[PARTITE_GIOCATE];
    _partiteVinte = datasnapshot.value[PARTITE_VINTE];
  }

  set partiteGiocate(int value) {
    _partiteGiocate = value;
  }

  int get partiteVinte => _partiteVinte;

  set partiteVinte(int value) {
    _partiteVinte = value;
  }


}