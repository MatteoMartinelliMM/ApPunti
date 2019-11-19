import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/DatabaseProvider.dart';

import 'AggiungiGiocatori/aggiungigiocatori.dart';
import 'Model/FirebaseDatabaseHelper.dart';
import 'Model/Giocatore.dart';

main() => runApp(ContaPunti());

class ContaPunti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    DatabaseProvider db = new DatabaseProvider();
    var databaseInstance = db.getDatabaseInstance();
    db.addUser(new Giocatore('mimmo'));
    return MaterialApp(
      title: 'Conta punti',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Seleziona gioco')), body: SelezionaGioco());
  }
}

class SelezionaGioco extends StatelessWidget {
  List<String> _giochi = new List();
  FirebaseDatabaseHelper fbDh = new FirebaseDatabaseHelper();

  @override
  Widget build(BuildContext context) {
    populateList();
    return Align(
        alignment: Alignment.center,
        child: ListView.separated(
            itemCount: _giochi.length,
            itemBuilder: (context, itemCount) {
              return getCustomChildElement(itemCount, context);
            },
            separatorBuilder: (context, itemCount) {
              return Divider();
            }));
  }

  ListTile getCustomChildElement(int index, BuildContext context) {
    return new ListTile(
      title: Align(
          alignment: Alignment.center,
          child: Text(_giochi[index], style: TextStyle(color: Colors.white))),
      leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset(getImageAssets(_giochi[index]))),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        onGiocoSelected(_giochi[index], context);
        fbDh.getAllGiocatori();
      },
    );
  }

  String getImageAssets(String gioco) {
    String basePath = 'assets/image/';
    String imageName = '';
    switch (gioco) {
      case BRISCOLA:
        imageName = "assocoppeicon.png";
        break;
      case BRISCOLA_A_CHIAMATA:
        imageName = "quattrodispadeicon.png";
        break;
      case SCOPONE_SCIENTIFICO:
        imageName = "assodenariicon.png";
        break;
      case SCOPA:
        imageName = "assobastoniicon.png";
        break;
      case CIRULLA:
        imageName = "assospadeicon.png";
        break;
      case ASSE:
        imageName = "cirulla.png";
        break;
      case PRESIDENTE:
        imageName = "presidenteicon.png";
        break;
    }
    return basePath + imageName;
  }

  void populateList() {
    _giochi.add(BRISCOLA);
    _giochi.add(BRISCOLA_A_CHIAMATA);
    _giochi.add(SCOPONE_SCIENTIFICO);
    _giochi.add(SCOPA);
    _giochi.add(CIRULLA);
    _giochi.add(ASSE);
    _giochi.add(PRESIDENTE);
  }

  void onGiocoSelected(String gioco, context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelezionaGiocatori(gioco)));
  }
}
