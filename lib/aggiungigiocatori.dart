import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/scopone.dart';

import 'AggiungiGiocatoriBriscolaAChiamata.dart';
import 'Model/Giocatore.dart';

class SelezionaGiocatori extends StatelessWidget {
  String gioco;

  SelezionaGiocatori(this.gioco);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleziona giocatori'),
      ),
      body: SelezionaGiocatoriBody(gioco),
    );
  }
}

class SelezionaGiocatoriBody extends StatefulWidget {
  String gioco;

  SelezionaGiocatoriBody(this.gioco);

  @override
  State<StatefulWidget> createState() {
    return SelezionaGiocatoriState(gioco);
  }
}

class SelezionaGiocatoriState extends State<SelezionaGiocatoriBody> {
  List<Giocatore> giocatori;
  List<FocusNode> focusNodeList;
  List<TextEditingController> controllerList;
  String gioco;

  SelezionaGiocatoriState(this.gioco);

  @override
  void initState() {
    switch (gioco) {
      case SCOPONE_SCIENTIFICO:
        giocatori = new List(4);
        focusNodeList = new List();
        controllerList = new List();
        for (int i = 0; i < giocatori.length; i++) {
          controllerList.add(new TextEditingController());
          focusNodeList.add(new FocusNode());
        }
        break;
      case PRESIDENTE:
      case ASSE:
        giocatori = new List();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (gioco) {
      case SCOPONE_SCIENTIFICO:
        return Scopone(giocatori, controllerList, focusNodeList, context);
      case BRISCOLA_A_CHIAMATA:
        return AggiungiGiocatoriBriscolaAChiamata();
      case PRESIDENTE:
      case ASSE:
        return giocatoriPresidente();
    }
  }

  Column giocatoriPresidente() {
    TextEditingController giocatoreController = new TextEditingController();
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: TextField(
                textInputAction: TextInputAction.done,
                controller: giocatoreController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Aggiungi o crea un nuovo giocatore"),
                onEditingComplete: () {
                  setState(() {
                    if (giocatoreController.text != null &&
                        giocatoreController.text.isNotEmpty)
                      giocatori.add(
                          new Giocatore.newGiocatore(giocatoreController.text));
                  });
                },
              ),
            )),
        Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return playerTile(context, giocatori[index]);
                },
                /*separatorBuilder: (context, index) {
                  return Divider();
                },*/
                itemCount: giocatori.length)),
      ],
    );
  }

  Widget playerTile(context, giocatore) {
    return Card(
      child: ListTile(
          title: Text(giocatore.name),
          leading: CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.asset('assets/image/defuser.png'),
          )),
    );
  }
}
