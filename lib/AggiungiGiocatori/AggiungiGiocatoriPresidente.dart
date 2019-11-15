import 'package:flutter/material.dart';
import 'package:flutter_app/AggiungiGiocatori/BaseAggiungiGiocatori.dart';
import 'package:flutter_app/AggiungiGiocatori/aggiungigiocatori.dart';
import 'package:flutter_app/Components/AutoCompleteText.dart';
import 'package:flutter_app/Components/AvatarImage.dart';

import '../ContaPunti/BaseContaPunti.dart';
import '../Model/Constants.dart';
import '../Model/Giocatore.dart';
import 'AggiungiGiocatoriBriscolaAChiamata.dart';

class AggiungiGiocatoriPresidente extends StatefulWidget
    implements BaseAggiungiGiocatori {
  List<Giocatore> giocatori;
  String gioco;

  OnNewGiocatore onNewGiocatore;

  VoidCallback toggleFab;

  AggiungiGiocatoriPresidente(
      this.giocatori, this.gioco, this.toggleFab, this.onNewGiocatore);

  @override
  State<StatefulWidget> createState() {
    return AggiungiGiocatoriPresidenteState();
  }

  @override
  bool canGoNext() {
    return gioco == PRESIDENTE
        ? giocatori?.length >= 4 ?? false
        : giocatori?.length >= 3 ?? false;
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
                      subtitle: Text(widget.giocatori[index].points.toString()),
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

  onGiocatoreSubmitted(Giocatore g) {
    setState(() {
      widget.giocatori.add(g);
      key = new ObjectKey(widget.giocatori);
      if (widget.canGoNext()) widget.toggleFab;
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
