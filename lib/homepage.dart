import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';

import 'Model/Giocatore.dart';

main() => runApp(ContaPunti());

class ContaPunti extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Conta punti',
      theme: ThemeData.dark(),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Seleziona gioco')), body: SelezionaGioco());
  }
}

class SelezionaGioco extends StatelessWidget {
  List<String> _giochi = new List();

  @override
  Widget build(BuildContext context) {
    populateList();
    return Align(
        alignment: Alignment.center,
        child: ListView.separated(
            itemCount: _giochi.length,
            itemBuilder: (context, itemCount) {
              return getCustomChildElement(itemCount, context);
            },
            separatorBuilder: (context, itemCount) {
              return Divider();
            }));
  }

  ListTile getCustomChildElement(int index, BuildContext context) {
    return new ListTile(
      title: Align(
          alignment: Alignment.center,
          child: Text(_giochi[index], style: TextStyle(color: Colors.white))),
      leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Image.asset(getImageAssets(_giochi[index]))),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: () {
        onGiocoSelected(_giochi[index], context);
      },
    );
  }

  String getImageAssets(String gioco) {
    String basePath = 'assets/image/';
    String imageName = '';
    switch (gioco) {
      case BRISCOLA:
        imageName = "assocoppeicon.png";
        break;
      case BRISCOLA_A_CHIAMATA:
        imageName = "quattrodispadeicon.png";
        break;
      case SCOPONE_SCIENTIFICO:
        imageName = "assodenariicon.png";
        break;
      case SCOPA:
        imageName = "assobastoniicon.png";
        break;
      case CIRULLA:
        imageName = "assospadeicon.png";
        break;
      case ASSE:
        imageName = "cirulla.png";
        break;
      case PRESIDENTE:
        imageName = "presidenteicon.png";
        break;
    }
    return basePath + imageName;
  }

  void populateList() {
    _giochi.add(BRISCOLA);
    _giochi.add(BRISCOLA_A_CHIAMATA);
    _giochi.add(SCOPONE_SCIENTIFICO);
    _giochi.add(SCOPA);
    _giochi.add(CIRULLA);
    _giochi.add(ASSE);
    _giochi.add(PRESIDENTE);
  }

  void onGiocoSelected(String gioco, context) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => SelezionaGiocatori(gioco)));
  }
}

class SelezionaGiocatori extends StatelessWidget {
  String gioco;

  SelezionaGiocatori(this.gioco);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seleziona giocatori'),
      ),
      body: Center(child: SelezionaGiocatoriBody(gioco)),
        resizeToAvoidBottomInset : false, /*adjiustPan*/
    );
  }
}

class SelezionaGiocatoriBody extends StatefulWidget {
  String gioco;

  SelezionaGiocatoriBody(this.gioco);

  @override
  State<StatefulWidget> createState() {
    return SelezionaGiocatoriState(gioco);
  }
}

class SelezionaGiocatoriState extends State<SelezionaGiocatoriBody> {
  List<Giocatore> _giocatori;
  String gioco;

  SelezionaGiocatoriState(this.gioco);

  @override
  Widget build(BuildContext context) {
    switch (gioco) {
      case SCOPONE_SCIENTIFICO:
        _giocatori = new List(4);
        return giocatoriScopone(_giocatori);
      case PRESIDENTE:
      case ASSE:
        _giocatori = new List();
        return giocatoriPresidente();
    }
  }

  Widget giocatoriScopone(List<Giocatore> giocatori) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
                flex: 10,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: teamElement(giocatori, 0, 1),
                )),
            Flexible(
                flex: 2,
                child: Align(
                  alignment: Alignment.center,
                  child: Image.asset('assets/image/vs.png'),
                )),
            Flexible(
                flex: 10,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: teamElement(giocatori, 2, 3),
                ))
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
        children: <Widget>[
          Flexible(child: teamCard(giocatori[giocatore1], giocatore1)),
          Flexible(child: teamCard(giocatori[giocatore2], giocatore2))
        ],
      ),
    );
  }

  Widget teamCard(Giocatore giocatore, int indexGiocatore) {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: nameAndImageFromPlayer(giocatore, indexGiocatore),
          ),
          Flexible(child: tabellaPunteggi(giocatore)),
        ],
      ),
    );
  }

  Visibility tabellaPunteggi(Giocatore giocatore) {
    //TODO: rendere dinamica la creazione delle colonne
    return Visibility(
        visible: haveGiocatore(giocatore),
        child: Padding(
            padding: EdgeInsets.only(top: 16.0, left: 16.0, right: 16.0),
            child: Table(
              children: [
                TableRow(children: [
                  Center(child: Text("PARTITE GIOCATE")),
                  Center(child: Text("PARTITE VINTE")),
                  Center(child: Text("PERCENTUALE"))
                ]),
                TableRow(children: [
                  Center(
                      child: Text("20",
                          style: TextStyle(fontStyle: FontStyle.italic))),
                  Center(
                      child: Text("20",
                          style: TextStyle(fontStyle: FontStyle.italic))),
                  Center(
                      child: Text("20",
                          style: TextStyle(fontStyle: FontStyle.italic))),
                ])
              ],
            )));
  }

  Row nameAndImageFromPlayer(Giocatore giocatore, int indexGiocatore) {
    return Row(
      children: <Widget>[
        Flexible(
          flex: 1,
          child: Padding(
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
        ),
        Flexible(
          flex: 4,
          child: Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Inserisci giocatore"),
              )),
        )
      ],
    );
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
                    if (giocatoreController.text != null)
                      _giocatori.add(
                          new Giocatore.newGiocatore(giocatoreController.text));
                  });
                },
              ),
            )),
        Expanded(
            child: ListView.builder(
                itemBuilder: (context, index) {
                  return playerTile(context, _giocatori[index]);
                },
                /*separatorBuilder: (context, index) {
                  return Divider();
                },*/
                itemCount: _giocatori.length)),
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

  bool haveGiocatore(Giocatore giocatore) {
    return giocatore.name != null && giocatore.name.isNotEmpty;
  }
}
