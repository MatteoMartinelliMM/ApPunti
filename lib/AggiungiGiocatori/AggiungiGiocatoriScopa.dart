import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/AggiungiGiocatori/aggiungigiocatori.dart';
import 'package:flutter_app/Components/AvatarImage.dart';
import 'package:flutter_app/ContaPunti/contapunti.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/FirebaseDatabaseHelper.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'BaseAggiungiGiocatori.dart';

class AggiungiGiocatoriScopa extends StatefulWidget
    implements BaseAggiungiGiocatori {
  VoidCallback callback;
  List<Giocatore> giocatori;
  String gioco;
  String howmanyPlayer;
  List<String> nrOfPlayer;

  List<TextEditingController> etCList;
  List<bool> isLoading;
  List<bool> valids;
  List<FocusNode> mFocusList;

  OnNewGiocatore onNewGiocatore;

  FirebaseDatabaseHelper fDbH;

  AggiungiGiocatoriScopa(
      this.giocatori, this.gioco, this.callback, this.onNewGiocatore) {
    fDbH = new FirebaseDatabaseHelper();
  }

  @override
  State<StatefulWidget> createState() {
    return new AggiungiGIocatoriScopaState();
  }

  @override
  bool canGoNext() {
    switch (howmanyPlayer) {
      case DUO:
        return allPlayersAreSetted(2);
      case TLE:
        return allPlayersAreSetted(3);
      case QUATLO:
        return false;
      default:
        return false;
    }
  }

  @override
  List<Giocatore> onFabClick() {
    return giocatori;
  }

  bool allPlayersAreSetted(int howMany) {
    if (giocatori == null || giocatori.length != howMany) return false;
    for (Giocatore g in giocatori)
      if (g.name == null || g.name.isEmpty) return false;
    return true;
  }
}

class AggiungiGIocatoriScopaState extends State<AggiungiGiocatoriScopa> {
  ObjectKey boolKey, validKey;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
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
                        widget.callback();
                      });
                    })),
          ),
          Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(child: getBody())))
        ],
      ),
    );
  }

  @override
  void initState() {
    widget.nrOfPlayer = new List();
    widget.nrOfPlayer.add(DUO);
    widget.nrOfPlayer.add(TLE);
    if (widget.gioco != CIRULLA) widget.nrOfPlayer.add(QUATLO);
    widget.howmanyPlayer = widget.nrOfPlayer[0];
    validKey = new ObjectKey(widget.valids);
    boolKey = new ObjectKey(widget.isLoading);
  }

  Widget getBody() {
    switch (widget.howmanyPlayer) {
      case DUO:
        widget.giocatori = widget.giocatori?.sublist(0, 2) ?? new List(2);
        widget.etCList = widget.etCList?.sublist(0, 2) ?? new List(2);
        widget.mFocusList = widget.mFocusList?.sublist(0, 2) ?? new List(2);
        widget.isLoading = widget.isLoading?.sublist(0, 2) ?? new List(2);
        widget.valids = widget.valids?.sublist(0, 2) ?? new List(2);
        for (int i = 0; i < 2; i++) {
          if (widget.etCList[i] == null)
            widget.etCList[i] = new TextEditingController();
          if (widget.giocatori[i] == null)
            widget.giocatori[i] = new Giocatore.newGiocatore('');
          if (widget.mFocusList[i] == null)
            widget.mFocusList[i] = new FocusNode();
          widget.etCList[i].text = widget.giocatori[i]?.name ?? '';
          widget.isLoading[i] = false;
          widget.valids[i] = true;
        }
        return duo();
      case TLE:
        keepInsertedPlayer(3);
        return tle();
      case QUATLO:
        if (widget.giocatori.length ==
            2) //PIGRIZIA PER NON FARE ALTRI CONTROLLI
          keepInsertedPlayer(3);
        keepInsertedPlayer(4);
        return quatlo();
    }
  }

  void keepInsertedPlayer(int toKeep) {
    if (widget.giocatori.length < toKeep) {
      List<Giocatore> tempList =
          widget.giocatori.sublist(0, toKeep - 1); //todo vedere come cambiarlo
      tempList.add(new Giocatore.newGiocatore(''));
      widget.giocatori = tempList;
      List<TextEditingController> tempListet =
          widget.etCList.sublist(0, toKeep - 1);
      tempListet.add(new TextEditingController());
      widget.etCList = tempListet;
      List<FocusNode> tempListFoc = widget.mFocusList.sublist(0, toKeep - 1);
      tempListFoc.add(new FocusNode());
      widget.mFocusList = tempListFoc;
      List<bool> tempValid = widget.valids.sublist(0, toKeep - 1);
      tempValid.add(true);
      widget.valids = tempValid;
      List<bool> tempIsLoading = widget.isLoading.sublist(0, toKeep - 1);
      tempIsLoading.add(false);
      widget.isLoading = tempIsLoading;
    } else {
      widget.giocatori = widget.giocatori.sublist(0, toKeep);
      widget.etCList = widget.etCList.sublist(0, toKeep);
      widget.mFocusList = widget.mFocusList.sublist(0, toKeep);
      widget.valids = widget.valids.sublist(0, toKeep);
      widget.isLoading = widget.isLoading.sublist(0, toKeep);
    }
  }

  Widget quatlo() {
    return Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              elevation: 2.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  teamCard(new Giocatore.newGiocatore(''), 0),
                  teamCard(new Giocatore.newGiocatore(''), 1)
                ],
              ),
            ),
            Center(
              child: Image.asset(IMAGE_PATH + 'vs_small.png'),
            ),
            Card(
              elevation: 2.0,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  teamCard(new Giocatore.newGiocatore(''), 2),
                  teamCard(new Giocatore.newGiocatore(''), 3)
                ],
              ),
            ),
            Center(
              child: RaisedButton(
                onPressed: onPressed(),
                child: Text("Gioca"),
              ),
            )
          ],
        ));
  }

  Widget tle() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  flex: 3,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Align(
                              alignment: Alignment.topCenter,
                              child:
                                  AvatarImage(widget.giocatori[0].url, 80, 80),
                            ),
                          ),
                          playerTextFiled(0),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Flexible(
                  flex: 3,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: AvatarImage(widget.giocatori[1].url, 80, 80),
                          ),
                          playerTextFiled(1),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Center(
            child: Image.asset(IMAGE_PATH + 'vs_small.png'),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(
                flex: 2,
              ),
              Flexible(
                flex: 3,
                child: Center(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Align(
                            alignment: Alignment.topCenter,
                            child: AvatarImage(widget.giocatori[2].url, 80, 80),
                          ),
                          playerTextFiled(2),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 2,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget duo() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: AvatarImage(widget.giocatori[0].url, 80, 80),
                        ),
                        Expanded(
                          child: playerTextFiled(0),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Image.asset(IMAGE_PATH + 'vs_small.png'),
          Padding(
            padding: const EdgeInsets.only(left: 4.0, right: 4.0),
            child: Card(
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: AvatarImage(widget.giocatori[1].url, 80, 80),
                        ),
                        Expanded(child: playerTextFiled(1))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  TextField playerTextFiled(int i) {
    return TextField(
      focusNode: widget.mFocusList[i],
      textInputAction: widget.mFocusList.length - 1 > i
          ? TextInputAction.next
          : TextInputAction.done,
      controller: widget.etCList[i],
      textCapitalization: TextCapitalization.words,
      onSubmitted: (value) {
        widget.fDbH
            .getGiocatore(value, widget.gioco)
            .then((Giocatore g) {
          setState(() {
            widget.isLoading[i] = true;
            widget.isLoading[i] = false;
            if (g != null && !widget.giocatori.contains(g)) {
              widget.isLoading[i] = true;
              widget.giocatori[i] = g;
              widget.etCList[i].text = g.name;
            } else if (g != null && widget.giocatori.contains(g)) {
              widget.valids[i] = false;
              widget.etCList[i].text = g.name;
            } else {
              widget.onNewGiocatore(value);
            }
            if (widget.mFocusList.length - 1 != i)
              FocusScope.of(context).requestFocus(widget.mFocusList[i + 1]);
            else
              SystemChannels.textInput.invokeMethod('TextInput.hide');
          });
        });
      },
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
        border: OutlineInputBorder(),
        labelText: 'Aggiungi o crea un nuovo giocatore',
      ),
    );
  }

  Widget teamCard(Giocatore giocatore, int indexGiocatore) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          nameAndImageFromPlayer(
              giocatore, indexGiocatore /*, controllerList[indexGiocatore]*/),
          tabellaPunteggi(giocatore),
        ],
      ),
    );
  }

  Row nameAndImageFromPlayer(
    Giocatore giocatore,
    int indexGiocatore,
    /*TextEditingController controller*/
  ) {
    //controller.text = giocatore.name;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: AvatarImage(widget.giocatori[indexGiocatore].url, 80, 80)),
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: playerTextFiled(indexGiocatore)),
        )
      ],
    );
  }

  Visibility tabellaPunteggi(Giocatore giocatore) {
    return Visibility(
        visible: true, //haveGiocatore(giocatore),
        child: Padding(
            padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
            child: Table(
              children: [
                TableRow(children: [
                  Center(
                    child: Text(
                      "PARTITE GIOCATE",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "PARTITE VINTE",
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "PERCENTUALE",
                      textAlign: TextAlign.center,
                    ),
                  )
                ]),
                TableRow(children: [
                  Center(
                    child: Text(
                      "20",
                      style: TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "20",
                      style: TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: Text(
                      "20",
                      style: TextStyle(fontStyle: FontStyle.italic),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ])
              ],
            )));
  }

  VoidCallback onPressed() {
    if (widget.allPlayersAreSetted(4)) {
      return () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ContaPuntiGiocatori(widget.giocatori, widget.gioco)));
      };
    } else
      return null;
  }
}
