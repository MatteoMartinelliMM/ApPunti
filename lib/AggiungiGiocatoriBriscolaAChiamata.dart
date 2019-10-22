import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';

import 'Model/Constants.dart';
import 'Model/Giocatore.dart';

class AggiungiGiocatoriBriscolaAChiamata extends StatefulWidget {
  List<Giocatore> giocatoriGiocanti;
  List<Giocatore> giocatoriFromBe;
  GlobalKey<AutoCompleteTextFieldState<Giocatore>> key;

  @override
  State<StatefulWidget> createState() {
    return new AggiungiGiocatoriBriscolaAChiamataState();
  }
}

class AggiungiGiocatoriBriscolaAChiamataState
    extends State<AggiungiGiocatoriBriscolaAChiamata> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: AutoCompleteTextField<Giocatore>(
              key: widget.key,
              suggestions: widget.giocatoriFromBe,
              itemBuilder: (context, item) {
                return ListTile(
                  leading: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(IMAGE_PATH + 'defuser.png'))),
                  ),
                  title: Text(item.name),
                );
              },
              itemFilter: (item, query) {
                return item.name.startsWith(query);
              },
              itemSorter: (g1, g2) {
                return g1.name.compareTo(g2.name);
              },
              itemSubmitted: (g) {
                setState(() {
                  widget.giocatoriGiocanti.add(g);
                });
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Aggiungi o crea un nuovo giocatore",
              ),
            ),
          ),
        ),
        Visibility(
          visible: widget.giocatoriGiocanti.isNotEmpty,
          child: ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(IMAGE_PATH + 'defuser.png'))),
                  ),
                  title: Text(widget.giocatoriGiocanti[index].name),
                  subtitle:
                      Text(widget.giocatoriGiocanti[index].points.toString()),
                );
              },
              separatorBuilder: (context, index) {
                new Divider();
              },
              itemCount: widget.giocatoriGiocanti.length),
        ),
        Visibility(
          visible: widget.giocatoriGiocanti.isEmpty,
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

  @override
  void initState() {
    widget.key = new GlobalKey();
    widget.giocatoriGiocanti = new List();
    widget.giocatoriFromBe = new List();
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Teo"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Tua mamma"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Tuo padre"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Scarse"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Gio"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Lore"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Vale"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Michi"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Ale"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Ally"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Marco"));
    widget.giocatoriFromBe.add(new Giocatore.newGiocatore("Dennis"));
  }
}
