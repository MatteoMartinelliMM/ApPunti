import 'package:flutter/material.dart';
import 'package:flutter_app/AggiungiGiocatori/aggiungigiocatori.dart';
import 'package:flutter_app/Components/AggiungiGiocatoriDialog.dart';
import 'package:flutter_app/Components/AvatarImage.dart';

import '../Components/AutoCompleteText.dart';
import '../Model/Giocatore.dart';
import 'BaseAggiungiGiocatori.dart';

typedef OnSubmitted = void Function(Giocatore g);

class AggiungiGiocatoriBriscolaAChiamata extends StatefulWidget
    implements BaseAggiungiGiocatori {
  List<Giocatore> giocatoriGiocanti;

  VoidCallback toggleFab;

  OnNewGiocatore onNewGiocatore;

  AggiungiGiocatoriBriscolaAChiamata(this.toggleFab, this.onNewGiocatore);

  @override
  State<StatefulWidget> createState() {
    giocatoriGiocanti = new List();
    return new AggiungiGiocatoriBriscolaAChiamataState();
  }

  @override
  bool canGoNext() {
    return giocatoriGiocanti != null && giocatoriGiocanti.length == 5;
  }

  @override
  List<Giocatore> onFabClick() {
    return giocatoriGiocanti;
  }
}

class AggiungiGiocatoriBriscolaAChiamataState
    extends State<AggiungiGiocatoriBriscolaAChiamata> {
  ObjectKey key;
  int state;

  OnSubmitted onSubmitted;

  @override
  Widget build(BuildContext context) {
    widget.giocatoriGiocanti = key.value;
    bool isEnable = widget.giocatoriGiocanti.length < 5;
    onSubmitted = onGiocatoreSubmitted;
    AutoCompleteText autoCompleteText =
        AutoCompleteText(onSubmitted, widget.onNewGiocatore, isEnable);
    return Column(
      key: key,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: autoCompleteText,
              ),
            ),
          ],
        ),
        Visibility(
          visible: widget?.giocatoriGiocanti?.isNotEmpty ?? false,
          child: Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: ObjectKey(widget.giocatoriGiocanti[index]),
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
                            widget.giocatoriGiocanti.removeAt(index), false);
                        widget.toggleFab();
                      });
                    },
                    child: ListTile(
                      leading: AvatarImage(
                          widget.giocatoriGiocanti[index].url, 60, 60),
                      title: Text(widget.giocatoriGiocanti[index].name),
                      subtitle: Text(
                          widget.giocatoriGiocanti[index].points.toString()),
                    ),
                  );
                },
                separatorBuilder: (context, itemCount) {
                  return Divider();
                },
                itemCount: widget?.giocatoriGiocanti?.length ?? 0),
          ),
        ),
        Visibility(
          visible: widget?.giocatoriGiocanti?.isEmpty ?? true,
          child: Center(
            child: Text(
              "Cerca giocatori o\n aggiungine uno nuovo",
              style: TextStyle(fontSize: 28),
              textAlign: TextAlign.center,
            ),
          ),
        )
      ],
    );
  }

  onGiocatoreSubmitted(Giocatore g) {
    setState(() {
      widget.giocatoriGiocanti.add(g);
      key = new ObjectKey(widget.giocatoriGiocanti);
      if (widget.canGoNext()) widget.toggleFab;
    });
  }


  @override
  void initState() {
    widget.giocatoriGiocanti = new List();
    key = new ObjectKey(widget.giocatoriGiocanti);
  }
}
