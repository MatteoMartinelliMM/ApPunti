import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/AggiungiGiocatori/aggiungigiocatori.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/FirebaseDatabaseHelper.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import '../AggiungiGiocatori/AggiungiGiocatoriBriscolaAChiamata.dart';

class AutoCompleteText extends StatefulWidget implements UpdateSelectedList {
  OnSubmitted onSubmitted;
  OnNewGiocatore onNewGiocatore;
  List<Giocatore> giocatoriFromBe;
  List<Giocatore> selectedGiocatori;
  FirebaseDatabaseHelper f;

  bool isEnable;

  @override
  State<StatefulWidget> createState() => AutoCompleteTextState();

  AutoCompleteText(this.onSubmitted, this.onNewGiocatore, this.isEnable);

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
  ObjectKey giocatoriKey, giocatoriBEKey;

  @override
  Widget build(BuildContext context) {
    widget.selectedGiocatori = giocatoriKey.value;
    widget.giocatoriFromBe = giocatoriBEKey.value;
    if (widget.giocatoriFromBe == null || widget.giocatoriFromBe.isEmpty)
      return FutureBuilder(
        future: widget.f.getAllGiocatori(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
            case ConnectionState.active:
              return CircularProgressIndicator();
            case ConnectionState.done:
              widget.giocatoriFromBe = snapshot.data;
              giocatoriBEKey = new ObjectKey(widget.giocatoriFromBe);
              return getAutoComplete();
          }
          ;
        },
      );
    else
      return getAutoComplete();
  }

  AutoCompleteTextField<Giocatore> getAutoComplete() {
    return AutoCompleteTextField<Giocatore>(
      key: key,
      suggestions: widget.giocatoriFromBe,
      clearOnSubmit: true,
      textSubmitted: (value) {
        Giocatore giocatore = new Giocatore.newGiocatore(value);
        if (!widget.giocatoriFromBe.contains(giocatore) &&
            !widget.selectedGiocatori.contains(giocatore))
          widget.onNewGiocatore(value);
        else if (widget.giocatoriFromBe.contains(giocatore) && !widget.selectedGiocatori.contains(giocatore))
          submitted(widget
              .giocatoriFromBe[widget.giocatoriFromBe.indexOf(giocatore)]);
      },
      itemBuilder: (context, item) {
        return ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(25.0),
            child: getUserImage(item),
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
      itemSubmitted: (g) => {submitted(g)},
      decoration: InputDecoration(
        enabled: widget.isEnable,
        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
        border: OutlineInputBorder(),
        labelText: "Aggiungi o crea un nuovo giocatore",
      ),
    );
  }

  Widget getUserImage(Giocatore g) {
    return g?.url.isNotEmpty
        ? FadeInImage(
            fit: BoxFit.fill,
            height: 50,
            width: 50,
            placeholder: AssetImage(IMAGE_PATH + 'progress.gif'),
            image: NetworkImage(g.url))
        : Image.asset(
              IMAGE_PATH + 'defuser.png',
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            ) ??
            Image.asset(IMAGE_PATH + 'defuser.png',
                height: 50, width: 50, fit: BoxFit.fill);
  }

  void submitted(Giocatore g) {
    if (widget.isEnable) {
      widget.updateGiocatore(g, true);
      giocatoriKey = new ObjectKey(widget.selectedGiocatori);
      widget.onSubmitted(g);
    }
  }

  @override
  void initState() {
    key = new GlobalKey();
    widget.selectedGiocatori = new List();
    widget.giocatoriFromBe = new List();
    widget.f = new FirebaseDatabaseHelper();
    giocatoriKey = new ObjectKey(widget.selectedGiocatori);
    giocatoriBEKey = new ObjectKey(widget.giocatoriFromBe);
  }
}

abstract class UpdateSelectedList {
  void updateGiocatore(Giocatore g, bool toAdd);
}
