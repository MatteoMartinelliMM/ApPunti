import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'BaseAggiungiGiocatori.dart';

class AggiungiGiocatoriScopa extends StatefulWidget
    implements BaseAggiungiGiocatori {
  VoidCallback callback;
  List<Giocatore> giocatori;
  String gioco;
  String howmanyPlayer;
  List<String> nrOfPlayer;

  AggiungiGiocatoriScopa(this.giocatori, this.gioco, this.callback);

  @override
  State<StatefulWidget> createState() {
    return new AggiungiGIocatoriScopaState();
  }

  @override
  bool canGoNext() {
    return false;
  }

  @override
  List<Giocatore> onFabClick() {
    // TODO: implement onFabClick
    return null;
  }
}

class AggiungiGIocatoriScopaState extends State<AggiungiGiocatoriScopa> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
              alignment: Alignment.topCenter,
              child: DropdownButton<String>(
                  value: widget.howmanyPlayer,
                  isExpanded: true,
                  items: widget.nrOfPlayer.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      widget.howmanyPlayer = value;
                    });
                  })),
        ),
        getBody()
      ],
    );
  }

  @override
  void initState() {
    widget.nrOfPlayer = new List();
    widget.nrOfPlayer.add(DUO);
    widget.nrOfPlayer.add(TLE);
    if (widget.gioco != CIRULLA) {
      widget.nrOfPlayer.add(QUATLO);
    }
    widget.howmanyPlayer = widget.nrOfPlayer[0];
  }

  Widget getBody() {
    switch (widget.howmanyPlayer) {
      case DUO:
        break;
      case TLE:
        break;
      case QUATLO:
        break;
    }
    return null;
  }
}
