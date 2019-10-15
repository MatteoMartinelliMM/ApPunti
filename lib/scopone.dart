import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import 'contapunti.dart';

List<FocusNode> focuseNodeList;
List<TextEditingController> controllerList;

class Scopone extends StatefulWidget {
  List<Giocatore> giocatori;
  List<TextEditingController> controllerList;
  List<FocusNode> focusNodeList;
  BuildContext context;

  Scopone(
      this.giocatori, this.controllerList, this.focusNodeList, this.context);

  @override
  State<StatefulWidget> createState() {
    return ScoponeState(giocatori, controllerList, focusNodeList, this.context);
  }
}

class ScoponeState extends State<Scopone> {
  List<Giocatore> giocatori;
  List<TextEditingController> controllerList;
  List<FocusNode> focusNodeList;
  BuildContext context;

  ScoponeState(this.giocatori, this.controllerList, this.focusNodeList, this.context);

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
                                builder: (context) =>
                                    ContaPuntiGiocatori(giocatori)));
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
          //TODO AGGIUNGERE FLEX
          teamCard(giocatori[giocatore2], giocatore2)
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
              giocatore, indexGiocatore, controllerList[indexGiocatore]),
          tabellaPunteggi(giocatore),
        ],
      ),
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

  Row nameAndImageFromPlayer(Giocatore giocatore, int indexGiocatore,
      TextEditingController controller) {
    controller.text = giocatore.name;
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
                controller: controller,
                focusNode: focusNodeList[indexGiocatore],
                textInputAction: TextInputAction.next,
                onSubmitted: (value) {
                  setState(() {
                    focusNodeList[indexGiocatore].unfocus();
                    if (focusNodeList.length - 1 != indexGiocatore)
                      FocusScope.of(context)
                          .requestFocus(focusNodeList[indexGiocatore + 1]);
                    else
                      SystemChannels.textInput
                          .invokeMethod('TextInput.hide'); //CLOSE KEYBOARD
                    if (controller.text != null && controller.text.isNotEmpty) {
                      giocatori[indexGiocatore].name = controller.text;
                    }
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

  bool haveGiocatore(Giocatore giocatore) {
    return giocatore.name != null && giocatore.name.isNotEmpty;
  }

  bool allPlayersAreSetted() {
    for (TextEditingController t in controllerList)
      if (t == null || t.text == null || t.text.isEmpty) return false;
    return true;
  }
}
