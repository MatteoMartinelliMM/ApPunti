import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/services.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/FirebaseDatabaseHelper.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import '../ContaPunti/contapunti.dart';
import 'BaseAggiungiGiocatori.dart';

List<FocusNode> focuseNodeList;
List<TextEditingController> controllerList;

class Scopone extends StatefulWidget implements BaseAggiungiGiocatori {
  List<Giocatore> giocatori;
  List<TextEditingController> controllerList;
  List<FocusNode> focusNodeList;
  BuildContext context;
  FirebaseDatabaseHelper fDbH;

  List<bool> isLoading;

  Scopone(
      this.giocatori, this.controllerList, this.focusNodeList, this.context) {
    fDbH = new FirebaseDatabaseHelper();
  }

  @override
  State<StatefulWidget> createState() {
    return ScoponeState(giocatori, controllerList, focusNodeList, this.context);
  }

  @override
  bool canGoNext() {
    return false;
  }

  @override
  List<Giocatore> onFabClick() {
    return null;
  }
}

class ScoponeState extends State<Scopone> {
  List<Giocatore> giocatori;
  List<TextEditingController> controllerList;
  List<FocusNode> focusNodeList;
  BuildContext context;
  ObjectKey boolKey;

  ScoponeState(
      this.giocatori, this.controllerList, this.focusNodeList, this.context);

  @override
  void initState() {
    widget.isLoading = new List();
    for (Giocatore g in widget.giocatori) widget.isLoading.add(false);
    boolKey = new ObjectKey(widget.isLoading);
  }

  @override
  Widget build(BuildContext context) {
    return giocatoriScopone(giocatori, controllerList, focusNodeList, context);
  }

  Widget giocatoriScopone(
      List<Giocatore> giocatori,
      List<TextEditingController> controllerList,
      List<FocusNode> focusNodeList,
      BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
              flex: 10,
              child: Align(
                alignment: Alignment.topLeft,
                child: teamElement(giocatori, 0, 1),
              ),
            ),
            Flexible(
              flex: 1,
              child: Align(
                alignment: Alignment.center,
                child: Image.asset('assets/image/vs_small.png'),
              ),
            ),
            Flexible(
              flex: 10,
              child: Align(
                alignment: Alignment.bottomRight,
                child: teamElement(giocatori, 2, 3),
              ),
            ),
            Flexible(
              flex: 2,
              child: RaisedButton(
                child: Text("Gioca"),
                onPressed: !allPlayersAreSetted()
                    ? null
                    : () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ContaPuntiGiocatori(
                                    giocatori, SCOPONE_SCIENTIFICO)));
                      },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget teamElement(
      List<Giocatore> giocatori, int giocatore1, int giocatore2) {
    if (giocatori[giocatore1] == null)
      giocatori[giocatore1] = new Giocatore.newGiocatore("");
    if (giocatori[giocatore2] == null)
      giocatori[giocatore2] = new Giocatore.newGiocatore("");
    return Card(
      elevation: 2.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          teamCard(giocatori[giocatore1], giocatore1),
          teamCard(giocatori[giocatore2], giocatore2)
        ],
      ),
    );
  }

  Widget teamCard(Giocatore giocatore, int indexGiocatore) {
    return Container(
      child: Column(
        children: getChildren(giocatore, indexGiocatore, widget.controllerList,
            widget.isLoading[indexGiocatore]),
      ),
    );
  }

  Visibility tabellaPunteggi(Giocatore giocatore) {
    return Visibility(
        visible: giocatore.gioco != null,
        child: giocatore.gioco == null
            ? Container()
            : Padding(
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
                          giocatore.gioco.partiteGiocate > 0
                              ? giocatore.gioco.partiteGiocate.toString()
                              : "N/D",
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          giocatore.gioco.partiteGiocate > 0
                              ? giocatore.gioco.partiteVinte.toString()
                              : "N/D",
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Center(
                        child: Text(
                          giocatore.gioco.partiteGiocate > 0
                              ? getPercentage(giocatore)
                              : "N/D",
                          style: TextStyle(fontStyle: FontStyle.italic),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ])
                  ],
                )));
  }

  Row nameAndImageFromPlayer(Giocatore giocatore, int indexGiocatore,
      TextEditingController controller) {
    controller.text = giocatore.name;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill, image: getImage(giocatore.url))),
            )),
        Expanded(
          child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: TextField(
                controller: controller,
                focusNode: focusNodeList[indexGiocatore],
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  widget.fDbH
                      .getGiocatore(value, SCOPONE_SCIENTIFICO)
                      .then((Giocatore g) {
                    setState(() {
                      widget.isLoading[indexGiocatore] = g == null;
                      if (g != null) {
                        widget.giocatori[indexGiocatore] = g;
                        controller.text = g.name;
                      }
                    });
                  });
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
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Inserisci giocatore"),
              )),
        )
      ],
    );
  }

  ImageProvider getImage(String url) {
    if (url == null || url.isEmpty)
      return AssetImage('assets/image/defuser.png');
    return NetworkImage(url);
  }

  bool haveGiocatore(Giocatore giocatore) {
    return giocatore.name != null && giocatore.name.isNotEmpty;
  }

  bool allPlayersAreSetted() {
    for (TextEditingController t in controllerList)
      if (t == null || t.text == null || t.text.isEmpty) return false;
    return true;
  }

  List<Widget> getChildren(Giocatore giocatore, int indexGiocatore,
      List<TextEditingController> contrtollerList, bool isLoading) {
    List<Widget> widgetList = new List();
    if ((giocatore.name == null || giocatore.name.isEmpty) && !isLoading)
      widgetList.add(nameAndImageFromPlayer(
          giocatore, indexGiocatore, contrtollerList[indexGiocatore]));
    if ((giocatore.name == null || giocatore.name.isEmpty) && isLoading) {
      widgetList.add(Stack(
        children: <Widget>[
          nameAndImageFromPlayer(
              giocatore, indexGiocatore, contrtollerList[indexGiocatore]),
          GestureDetector(
            onTap: null,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaY: 5.0, sigmaX: 5.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        ],
      ));
    }
    if (giocatore.name != null && giocatore.name.isNotEmpty) {
      widgetList.add(nameAndImageFromPlayer(
          giocatore, indexGiocatore, contrtollerList[indexGiocatore]));
      widgetList.add(tabellaPunteggi(giocatore));
    }
    return widgetList;
  }

  String getPercentage(Giocatore giocatore) {
    return (giocatore.gioco.partiteGiocate > 0 &&
                    giocatore.gioco.partiteVinte == 0
                ? 0
                : (giocatore.gioco.partiteVinte /
                        giocatore.gioco.partiteGiocate) *
                    100)
            .toString() +
        '%';
  }
}
