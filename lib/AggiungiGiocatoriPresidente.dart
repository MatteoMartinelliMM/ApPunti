import 'package:flutter/material.dart';

import 'BaseContaPunti.dart';
import 'Model/Constants.dart';
import 'Model/Giocatore.dart';

class AggiungiGiocatoriPresidente extends StatefulWidget
    implements BaseContaPunti {
  List<Giocatore> giocatori;
  String gioco;

  AggiungiGiocatoriPresidente(this.giocatori, this.gioco, VoidCallback toggleFab);

  @override
  State<StatefulWidget> createState() {
    return AggiungiGiocatoriPresidenteState();
  }

  @override
  bool calcolaVittoria() {
    return gioco == PRESIDENTE
        ? giocatori?.length >= 4 ?? false
        : giocatori?.length >= 3 ?? false;
  }
}

class AggiungiGiocatoriPresidenteState
    extends State<AggiungiGiocatoriPresidente> {
  @override
  Widget build(BuildContext context) {
    return giocatoriPresidente();
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
                      widget.giocatori.add(
                          new Giocatore.newGiocatore(giocatoreController.text));
                  });
                },
              ),
            )),
        Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return playerTile(context, widget.giocatori[index]);
                },
                /*separatorBuilder: (context, index) {
                  return Divider();
                },*/
                itemCount: widget.giocatori.length)),
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
