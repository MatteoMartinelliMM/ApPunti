import 'package:flutter/material.dart';
import 'package:flutter_app/AggiungiGiocatori/BaseAggiungiGiocatori.dart';
import 'package:flutter_app/AggiungiGiocatori/aggiungigiocatori.dart';
import 'package:flutter_app/Components/AutoCompleteText.dart';
import 'package:flutter_app/Components/AvatarImage.dart';
import 'package:flutter_app/Model/FirebaseDatabaseHelper.dart';
import 'package:flutter_app/Model/Giochi/Asse.dart';
import 'package:flutter_app/Model/Giochi/Gioco.dart';
import 'package:flutter_app/Model/Giochi/Presidente.dart';

import '../Model/Constants.dart';
import '../Model/Giocatore.dart';
import 'AggiungiGiocatoriBriscolaAChiamata.dart';

class AggiungiGiocatoriPresidente extends StatefulWidget
    implements BaseAggiungiGiocatori {
  List<Giocatore> giocatori;
  String gioco;

  OnNewGiocatore onNewGiocatore;

  FirebaseDatabaseHelper fbDbH;
  VoidCallback toggleFab;

  AggiungiGiocatoriPresidente(
      this.giocatori, this.gioco, this.toggleFab, this.onNewGiocatore) {
    fbDbH = new FirebaseDatabaseHelper();
  }

  @override
  State<StatefulWidget> createState() {
    return AggiungiGiocatoriPresidenteState();
  }

  @override
  bool canGoNext() {
    bool canGoNext = gioco == PRESIDENTE
        ? giocatori?.length >= 4 ?? false
        : giocatori?.length >= 3 ?? false;
    if (canGoNext) {
      for (Giocatore g in giocatori) {
        if (g.gioco == null) return false;
      }
    }
    return canGoNext;
  }

  @override
  List<Giocatore> onFabClick() {
    return giocatori;
  }
}

class AggiungiGiocatoriPresidenteState
    extends State<AggiungiGiocatoriPresidente> {
  OnSubmitted onSubmitted;

  ObjectKey key;

  @override
  Widget build(BuildContext context) {
    return giocatoriPresidente();
  }

  Column giocatoriPresidente() {
    onSubmitted = onGiocatoreSubmitted;
    bool isEnable = widget.giocatori.length < 14;
    AutoCompleteText autoCompleteText =
        AutoCompleteText(onSubmitted, widget.onNewGiocatore, isEnable);
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 8.0, left: 4.0, right: 4.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: autoCompleteText,
            )),
        Expanded(
          child: Visibility(
            visible: widget?.giocatori?.isNotEmpty ?? false,
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ObjectKey(widget.giocatori[index]),
                    background: Container(
                      color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.delete, color: Colors.white),
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Center(
                                child: Text(
                              "Rimuovi Giocatore",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            )),
                          ),
                        ],
                      ),
                    ),
                    secondaryBackground: Container(
                      color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Center(
                                child: Text(
                              "Rimuovi Giocatore",
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            )),
                          ),
                          Icon(Icons.delete, color: Colors.white)
                        ],
                      ),
                    ),
                    onDismissed: (dismissDirection) {
                      setState(() {
                        autoCompleteText.updateGiocatore(
                            widget.giocatori.removeAt(index), false);
                        widget.toggleFab();
                      });
                    },
                    child: ListTile(
                      leading: AvatarImage(widget.giocatori[index].url, 60, 60),
                      title: Text(widget.giocatori[index].name),
                      subtitle: Text(fillDescription(widget.giocatori[index])),
                    ),
                  );
                },
                separatorBuilder: (context, itemCount) {
                  return Divider();
                },
                itemCount: widget?.giocatori?.length ?? 0),
          ),
        ),
      ],
    );
  }

  String fillDescription(Giocatore g) {
    String toReturn = "";
    if (g.gioco != null) {
      toReturn =
          "Presidente: " + g.gioco.partiteVinte.toString() + " Schiavo: ";
      if (widget.gioco == PRESIDENTE)
        toReturn += (g.gioco as Presidente).schiavo.toString();
      else
        toReturn += (g.gioco as Asse).schiavo.toString();
    }
    return toReturn;
  }

  onGiocatoreSubmitted(Giocatore g) {
    setState(() {
      widget.giocatori.add(g);
      key = new ObjectKey(widget.giocatori);
      widget.fbDbH.getGiocoInfos(widget.gioco, g.name).then((Gioco gioco) {
        setState(() {
          widget.giocatori[widget.giocatori.indexOf(g)].gioco = gioco;
          if (widget.canGoNext()) widget.toggleFab;
        });
      });
    });
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
