import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AggiungiGiocatori/AggiungiGiocatoriScopone.dart';
import 'package:flutter_app/Components/AggiungiGiocatoriDialog.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giochi/ScoponeGioco.dart';

import '../ContaPunti/contapunti.dart';
import '../Model/Giocatore.dart';
import 'AggiungiGiocatoriBriscolaAChiamata.dart';
import 'AggiungiGiocatoriPresidente.dart';
import 'AggiungiGiocatoriScopa.dart';
import 'BaseAggiungiGiocatori.dart';

typedef OnNewGiocatore = void Function(String name);

class SelezionaGiocatori extends StatefulWidget {
  String gioco;

  Giocatore loggedUser;

  SelezionaGiocatori(this.gioco, this.loggedUser);

  BaseAggiungiGiocatori baseAggiungiGiocatori;

  @override
  Widget build(BuildContext context) {}

  @override
  State<StatefulWidget> createState() {
    return SelezionaGiocatoriState(gioco);
  }
}

class SelezionaGiocatoriState extends State<SelezionaGiocatori> {
  List<Giocatore> giocatori;
  List<FocusNode> focusNodeList;
  List<TextEditingController> controllerList;
  String gioco;
  Widget aggiungiGiocatoriBody;
  ObjectKey key;
  OnNewGiocatore onNewGiocatore;

  SelezionaGiocatoriState(this.gioco);

  @override
  void initState() {
    onNewGiocatore = onNewPlayer;
    switch (gioco) {
      case BRISCOLA:
      case SCOPA:
      case CIRULLA:
        aggiungiGiocatoriBody =
            new AggiungiGiocatoriScopa(giocatori, gioco, () {
          onMinimumGiocatoriReached();
        }, onNewGiocatore);
        break;
      case SCOPONE_SCIENTIFICO:
        giocatori = new List(4);
        widget.loggedUser.gioco = widget.loggedUser.giochi
            .where((g) => g is ScoponeGioco)
            .toList()[0];
        focusNodeList = new List();
        controllerList = new List();
        for (int i = 0; i < giocatori.length; i++) {
          controllerList.add(new TextEditingController());
          focusNodeList.add(new FocusNode());
        }
        aggiungiGiocatoriBody = new Scopone(
            giocatori, controllerList, focusNodeList, context, onNewGiocatore);
        break;
      case BRISCOLA_A_CHIAMATA:
        aggiungiGiocatoriBody = AggiungiGiocatoriBriscolaAChiamata(() {
          onMinimumGiocatoriReached();
        }, onNewGiocatore);
        break;
      case PRESIDENTE:
      case ASSE:
        giocatori = new List();
        aggiungiGiocatoriBody =
            new AggiungiGiocatoriPresidente(giocatori, gioco, () {
          onMinimumGiocatoriReached();
        }, onNewGiocatore);
        break;
    }
    widget.baseAggiungiGiocatori =
        aggiungiGiocatoriBody as BaseAggiungiGiocatori;
    key = new ObjectKey(widget.baseAggiungiGiocatori);
  }

  @override
  Widget build(BuildContext context) {
    widget.baseAggiungiGiocatori = key.value;
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleziona giocatori'),
      ),
      floatingActionButton: Visibility(
          visible: widget.baseAggiungiGiocatori.canGoNext(),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContaPuntiGiocatori(
                          widget.baseAggiungiGiocatori.onFabClick(),
                          widget.gioco)));
            },
            child: Icon(Icons.navigate_next),
          )),
      body: aggiungiGiocatoriBody,
    );
  }

  VoidCallback onMinimumGiocatoriReached() {
    setState(() {});
  }

  onNewPlayer(String value) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AggiungiGiocatoriDialog(value);
        });
  }
}
