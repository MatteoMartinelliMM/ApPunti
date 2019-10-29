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
                      });
                    })),
          ),
          Expanded(child: Align(alignment: Alignment.center, child: getBody()))
        ],
      ),
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
        return duo();
      case TLE:
        return tle();
      case QUATLO:
        return quatlo();
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
                  teamCard(new Giocatore.newGiocatore(""), 0),
                  teamCard(new Giocatore.newGiocatore(""), 1)
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
                  teamCard(new Giocatore.newGiocatore(""), 0),
                  teamCard(new Giocatore.newGiocatore(""), 1)
                ],
              ),
            ),
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
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          IMAGE_PATH + 'defuser.png'))),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
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
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          IMAGE_PATH + 'defuser.png'))),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
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
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: AssetImage(
                                          IMAGE_PATH + 'defuser.png'))),
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
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
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        IMAGE_PATH + 'defuser.png'))),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
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
                          child: Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: AssetImage(
                                        IMAGE_PATH + 'defuser.png'))),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                              border: OutlineInputBorder(),
                              labelText: "Aggiungi o crea un nuovo giocatore",
                            ),
                          ),
                        )
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
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/image/defuser.png'))),
            )),
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: TextField(
                // controller: controller,
                //focusNode: focusNodeList[indexGiocatore],
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  setState(() {
                    /*focusNodeList[indexGiocatore].unfocus();
                    if (focusNodeList.length - 1 != indexGiocatore)
                      FocusScope.of(context)
                          .requestFocus(focusNodeList[indexGiocatore + 1]);
                    else
                      SystemChannels.textInput
                          .invokeMethod('TextInput.hide'); //CLOSE KEYBOARD
                    if (controller.text != null && controller.text.isNotEmpty) {
                      giocatori[indexGiocatore].name = controller.text;
                    }*/
                  });
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Inserisci giocatore"),
              )),
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
}
