import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';

class Briscola extends Gioco {
  Briscola.fromSnapshot(DataSnapshot datasnapshot)
      : super.fromSnapshot(datasnapshot);

  Briscola.giocoForFb() : super.giocoForFb();
}
