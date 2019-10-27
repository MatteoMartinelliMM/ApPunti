import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import '../AggiungiGiocatori/AggiungiGiocatoriBriscolaAChiamata.dart';

class AutoCompleteText extends StatefulWidget implements UpdateSelectedList {
  OnSubmitted onSubmitted;

  List<Giocatore> giocatoriFromBe;
  List<Giocatore> selectedGiocatori;

  bool isEnable;

  @override
  State<StatefulWidget> createState() => AutoCompleteTextState();

  AutoCompleteText(this.onSubmitted, this.isEnable);

  @override
  void updateGiocatore(Giocatore g, bool toAdd) {
    if (toAdd)
      selectedGiocatori.add(g);
    else
      selectedGiocatori.remove(g);
  }
}

class AutoCompleteTextState extends State<AutoCompleteText> {
  GlobalKey<AutoCompleteTextFieldState<Giocatore>> key;
  ObjectKey giocatoriKey;

  @override
  Widget build(BuildContext context) {
    widget.selectedGiocatori = giocatoriKey.value;
    return AutoCompleteTextField<Giocatore>(
      key: key,
      suggestions: widget.giocatoriFromBe,
      clearOnSubmit: true,
      itemBuilder: (context, item) {
        return ListTile(
          leading: Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage(IMAGE_PATH + 'defuser.png'))),
          ),
          title: Text(item.name),
        );
      },
      textInputAction: TextInputAction.done,
      itemFilter: (item, query) {
        return widget.isEnable &&
            !widget.selectedGiocatori.contains(item) &&
            item.name.length > 2 &&
            item.name.startsWith(query);
      },
      itemSorter: (g1, g2) {
        return g1.name.compareTo(g2.name);
      },
      itemSubmitted: (g) => {
        if (widget.isEnable)
          {
            widget.updateGiocatore(g, true),
            giocatoriKey = new ObjectKey(widget.selectedGiocatori),
            widget.onSubmitted(g)
          }
      },
      decoration: InputDecoration(
        enabled: widget.isEnable,
        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
        border: OutlineInputBorder(),
        labelText: "Aggiungi o crea un nuovo giocatore",
      ),
    );
  }

  @override
  void initState() {
    key = new GlobalKey();
    widget.selectedGiocatori = new List();
    widget.giocatoriFromBe = new List();
    giocatoriKey = new ObjectKey(widget.selectedGiocatori);
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

abstract class UpdateSelectedList {
  void updateGiocatore(Giocatore g, bool toAdd);
}
