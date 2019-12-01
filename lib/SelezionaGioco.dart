import 'package:flutter/material.dart';
import 'package:flutter_app/Components/AvatarImage.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'AggiungiGiocatori/aggiungigiocatori.dart';
import 'Model/Constants.dart';

class HomePage extends StatelessWidget {
  Giocatore giocatore;

  HomePage(this.giocatore);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Seleziona gioco')),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              Container(
                child: AvatarImage(giocatore.url, 120, 120),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Center(
                    child:
                        Text(giocatore.name, style: TextStyle(fontSize: 18))),
              ),
              ListTile(
                onTap: () {},
                title: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text('Stats', style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
        body: SelezionaGioco(giocatore));
  }
}

class SelezionaGioco extends StatelessWidget {
  List<String> _giochi = new List();
  Giocatore giocatore;

  SelezionaGioco(this.giocatore);

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
        /*DatabaseProvider db = new DatabaseProvider();
        List<Gioco> giochi = new List();
        giochi.add(new ScoponeGioco.giocoForFb());
        giochi.add(new BriscolaAChiamata.giocoForFb());
        giochi.add(new Presidente.giocoForFb());
        db.insertAllGiochi(giochi, 'Mimmo');*/
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