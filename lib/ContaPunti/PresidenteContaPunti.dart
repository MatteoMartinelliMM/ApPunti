import 'package:flutter/material.dart';
import 'package:flutter_app/Components/AvatarImage.dart';
import 'package:flutter_app/Components/CounterLayout.dart';
import 'package:flutter_app/ContaPunti/BaseContaPunti.dart';
import 'package:flutter_app/Model/FirebaseDatabaseHelper.dart';
import 'package:flutter_app/Model/Giocatore.dart';
import 'package:flutter_app/Model/Giochi/Presidente.dart';

import '../Model/Constants.dart';

class PresidenteContaPunti extends StatefulWidget implements BaseContaPunti {
  String gioco;

  List<Giocatore> giocatori;
  List<int> countPresidente;
  List<int> countSchiavo;
  List<TextEditingController> etCSchiavoList;
  List<TextEditingController> etCPresidenteList;

  bool enable = false;

  VoidCallback callbackDialog;

  PresidenteContaPunti(this.giocatori, this.gioco, this.callbackDialog) {
    countPresidente = new List();
    countSchiavo = new List();
    etCSchiavoList = new List();
    etCPresidenteList = new List();
    for (int i = 0; i < giocatori.length; i++) {
      int count = 0;
      countPresidente.add(count);
      countSchiavo.add(count);
      TextEditingController etSchiavo = new TextEditingController();
      TextEditingController etPres = new TextEditingController();
      etCSchiavoList.add(etSchiavo);
      etCPresidenteList.add(etPres);
      etPres.text = count.toString();
      etSchiavo.text = count.toString();
    }
  }

  @override
  bool calcolaVittoria() {
    return false;
  }

  @override
  State<StatefulWidget> createState() {
    return new PresidenteContaPuntiState();
  }

  @override
  void updatePartita() {
    int totPartite = getTotPartite();
    for (Giocatore g in giocatori) {
      g.gioco.partiteGiocate += totPartite;
      g.gioco.partiteVinte += countPresidente[giocatori.indexOf(g)];
      (g.gioco as Presidente).schiavo += countSchiavo[giocatori.indexOf(g)];
    }
    FirebaseDatabaseHelper fbdh = new FirebaseDatabaseHelper();
    fbdh.updateGioco(giocatori, gioco);
  }

  int getTotPartite() {
    int toRet;
    for (int i in countPresidente) toRet += i;
    return toRet;
  }
}

class PresidenteContaPuntiState extends State<PresidenteContaPunti> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) {
                return buildSingleElement(index);
              },
              separatorBuilder: (context, index) {
                return new Divider();
              },
              itemCount: widget.giocatori.length),
        ),
        Center(
          child: RaisedButton(
            child: Text("Salva"),
            onPressed: widget.enable
                ? () {
                    setState(() {
                      widget.callbackDialog();
                    });
                  }
                : null,
          ),
        )
      ],
    );
  }

  Container buildSingleElement(int index) {
    TextEditingController etCP = widget.etCPresidenteList[index];
    TextEditingController etCS = widget.etCSchiavoList[index];
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AvatarImage(widget.giocatori[index].url, 50, 50),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.giocatori[index].name,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CounterLayout.sizedLayoutWithCustomRightButton(
                    etCP, IMAGE_PATH + 'presidentebutton.png', 30, 60, () {
                  decrementPresidenteCounter(index, etCP);
                }, () {
                  incrementPresidenteCounter(index, etCP);
                }, () {
                  onPresidenteTextChange(index, etCP);
                }),
              )
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: CounterLayout.sizedLayoutWithCustomRightButton(
                    etCS, IMAGE_PATH + 'schiavo.png', 30, 60, () {
                  decrementSchiavoCounter(index, etCS);
                }, () {
                  incrementSchiavoCounter(index, etCS);
                }, () {
                  onSchiavoTextChange(index, etCS);
                }),
              )
            ],
          )
        ],
      ),
    );
  }

  void incrementPresidenteCounter(int index, TextEditingController etC) {
    setState(() {
      widget.countPresidente[index]++;
      etC.text = widget.countPresidente[index].toString();
      setState(() {
        widget.enable = calcolaWin();
      });
    });
  }

  void decrementPresidenteCounter(int index, TextEditingController etC) {
    setState(() {
      widget.countPresidente[index]--;
      etC.text = widget.countPresidente[index].toString();
      setState(() {
        widget.enable = calcolaWin();
      });
    });
  }

  void onPresidenteTextChange(int index, TextEditingController etC) {
    setState(() {
      widget.countPresidente[index] = etC.text as int;
      setState(() {
        widget.enable = calcolaWin();
      });
    });
  }

  void incrementSchiavoCounter(int index, TextEditingController etC) {
    setState(() {
      widget.countSchiavo[index]++;
      etC.text = widget.countSchiavo[index].toString();
      setState(() {
        widget.enable = calcolaWin();
      });
    });
  }

  void decrementSchiavoCounter(int index, TextEditingController etC) {
    setState(() {
      widget.countSchiavo[index]--;
      etC.text = widget.countSchiavo[index].toString();
      setState(() {
        widget.enable = calcolaWin();
      });
    });
  }

  void onSchiavoTextChange(int index, TextEditingController etC) {
    setState(() {
      widget.countSchiavo[index] = etC.text as int;
      setState(() {
        widget.enable = calcolaWin();
      });
    });
  }

  bool calcolaWin() {
    for (int c in widget.countPresidente) if (c > 0) return true;
    return false;
  }
}
