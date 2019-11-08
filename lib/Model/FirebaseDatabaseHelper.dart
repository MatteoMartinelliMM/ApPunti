import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/FirebaseConstans.dart';
import 'package:flutter_app/Model/Giochi/Briscola.dart';
import 'package:flutter_app/Model/Giochi/Scopa.dart';

import 'Giocatore.dart';
import 'Giochi/Asse.dart';
import 'Giochi/BriscolaAChiamata.dart';
import 'Giochi/Cirulla.dart';
import 'Giochi/Gioco.dart';
import 'Giochi/Presidente.dart';
import 'Giochi/ScoponeGioco.dart';

class FirebaseDatabaseHelper {
  final database = FirebaseDatabase.instance.setPersistenceEnabled(true);
  final databaseReference = FirebaseDatabase.instance.reference();

  void createChild(int wo) {
    String title = "gesu" + wo.toString();
    databaseReference.child("dio" + wo.toString()).set({'title': 'stronzo'});
  }

  Future<Gioco> getGiocoInfos(String gioco, String giocatore) async {
    Gioco g = await databaseReference
        .child(GIOCHI)
        .child(gioco.toLowerCase().replaceAll(" ", ""))
        .child(giocatore)
        .once()
        .then((DataSnapshot datasnaphot) {
      //Gioco gioco = datasnaphot.runtimeType as Gioco;
      Gioco giocoObj;
      switch (gioco) {
        case BRISCOLA:
          giocoObj = Briscola.fromSnapshot(datasnaphot);
          break;
        case BRISCOLA_A_CHIAMATA:
          giocoObj = BriscolaAChiamata.fromSnapshot(datasnaphot);
          break;
        case SCOPONE_SCIENTIFICO:
          giocoObj = ScoponeGioco.fromSnapshot(datasnaphot);
          break;
        case SCOPA:
          giocoObj = Scopa.fromSnapshot(datasnaphot);
          break;
        case CIRULLA:
          giocoObj = Cirulla.fromSnapshot(datasnaphot);
          break;
        case ASSE:
          giocoObj = Asse.fromSnapshot(datasnaphot);
          break;
        case PRESIDENTE:
          giocoObj = Presidente.fromSnapshot(datasnaphot);
          break;
      }
      return giocoObj;
    });
    return g;
  }

  Future<Giocatore> getGiocatore(String name, String gioco) async {
    Giocatore g = await databaseReference
        .child(UTENTI)
        .child(name)
        .once()
        .then((DataSnapshot datasnaphot) async {
      if (datasnaphot.value[NAME] != null) {
        Giocatore giocatore = Giocatore.fromSnapshot(datasnaphot);
        if (gioco != null) {
          Gioco g = await getGiocoInfos(gioco, name);
          giocatore.gioco = g;
          return giocatore;
        } else
          return giocatore;
      } else
        return null;
    });
    return g;
  }

  /*Future<Giocatore> getGiocatoreFuture(String name, String gioco) async {
    databaseReference
        .child(UTENTI)
        .child(name)
        .once()
        .then((DataSnapshot datasnaphot) {
      if (datasnaphot.value[NAME] != null) {
        Giocatore giocatore = Giocatore.fromSnapshot(datasnaphot);
        if (gioco != null) {
          giocatore.gioco = getGiocoInfos(gioco, name);
          return giocatore;
        } else
          return giocatore;
      } else
        return null;
    });
  }*/

  Future<Giocatore> getGiocatoreBo(
      String name, String gioco, FutureOr<dynamic> dataSnapshot) {
    databaseReference.child(UTENTI).child(name).once().then(dataSnapshot);
  }

  void updateGioco(List<Giocatore> giocatori, String gioco) {
    for (Giocatore g in giocatori) {
      databaseReference.child(gioco).child(g.name).update(
          g.gioco is BriscolaAChiamata
              ? g.gioco.asMapBriscolaAChiamata()
              : g.gioco.asMap());
    }
  }
}
