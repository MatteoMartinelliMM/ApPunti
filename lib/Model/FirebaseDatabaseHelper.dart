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
  final _database = FirebaseDatabase.instance.setPersistenceEnabled(true);
  DatabaseReference _databaseReference;

  void createChild(int wo) {
    String title = "gesu" + wo.toString();
    _databaseReference.child("dio" + wo.toString()).set({'title': 'stronzo'});
  }

  FirebaseDatabaseHelper() {
    _databaseReference = FirebaseDatabase.instance.reference();
  }

  Future<Gioco> getGiocoInfos(String gioco, String giocatore) async {
    Gioco g = await _databaseReference
        .child(GIOCHI)
        .child(formatGiocoForFirebase(gioco))
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
    Giocatore g = await _databaseReference
        .child(UTENTI)
        .child(name)
        .once()
        .then((DataSnapshot datasnaphot) async {
      if (datasnaphot.value != null && datasnaphot.value[NAME] != null) {
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

  Future<List<Giocatore>> getAllGiocatori() async {
    List<Giocatore> giocatori = await _databaseReference
        .child(UTENTI)
        .once()
        .then((DataSnapshot snapshot) {
      List<dynamic> keys = (snapshot.value as Map).keys.toList();
      List<Giocatore> giocatori = new List();
      for (String k in keys) {
        Giocatore g = Giocatore.fromFirebaseMap(snapshot.value[k]);
        giocatori.add(g);
      }
      return giocatori;
    });
    return giocatori;
  }

  void updateGioco(List<Giocatore> giocatori, String gioco) {
    for (Giocatore g in giocatori) {
      _databaseReference
        ..child(GIOCHI).child(formatGiocoForFirebase(gioco)).child(g.name).update(
            g.gioco is BriscolaAChiamata
                ? g.gioco.asMapBriscolaAChiamata()
                : g.gioco.asMap());
    }
  }

  void createGiocatore(String name, String numero) {
    List<String> giochi = new List();
    giochi.add(SCOPA);
    giochi.add(SCOPONE_SCIENTIFICO);
    giochi.add(BRISCOLA);
    giochi.add(BRISCOLA_A_CHIAMATA);
    giochi.add(PRESIDENTE);
    giochi.add(ASSE);
    giochi.add(CIRULLA);
    Giocatore g = Giocatore.newGiocatoreForFB(name, numero);
    _databaseReference.child(UTENTI).child(name).set(g.giocatoreAsFirebaseMap());
    int count = 0;
    for (String g in giochi) {
      count++;
      Gioco gioco;
      switch (g) {
        case BRISCOLA:
          gioco = Briscola.giocoForFb();
          break;
        case BRISCOLA_A_CHIAMATA:
          gioco = BriscolaAChiamata.giocoForFb();
          break;
        case SCOPONE_SCIENTIFICO:
          gioco = ScoponeGioco.giocoForFb();
          break;
        case SCOPA:
          gioco = Scopa.giocoForFb();
          break;
        case CIRULLA:
          gioco = Cirulla.giocoForFb();
          break;
        case ASSE:
          gioco = Asse.giocoForFb();
          break;
        case PRESIDENTE:
          gioco = Presidente.giocoForFb();
          break;
      }
      _databaseReference
          .child(GIOCHI)
          .child(formatGiocoForFirebase(g))
          .child(name)
          .set(gioco is BriscolaAChiamata
              ? gioco.asMapBriscolaAChiamata()
              : gioco.asMap())
          .then((value) {
        if (count >= giochi.length - 1)
          _databaseReference = FirebaseDatabase.instance.reference();
      });
    }
  }

  String formatGiocoForFirebase(String g) {
    return g
            .toLowerCase()
            .replaceAll(" ", "")
            .replaceAll("!", "")
            .toLowerCase();
  }
}
