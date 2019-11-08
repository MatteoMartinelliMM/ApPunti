import 'package:flutter/material.dart';
import 'package:flutter_app/Components/CounterLayout.dart';
import 'package:flutter_app/ContaPunti/BaseContaPunti.dart';
import 'package:flutter_app/Model/Giocatore.dart';

import '../Model/Constants.dart';

class PresidenteContaPunti extends StatefulWidget implements BaseContaPunti {
  String gioco;

  List<Giocatore> giocatori;
  List<int> countPresidente;
  List<int> countSchiavo;
  List<TextEditingController> etCSchiavoList;
  List<TextEditingController> etCPresidenteList;

  PresidenteContaPunti(this.giocatori, this.gioco) {
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
    // TODO: implement updatePartita
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
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(IMAGE_PATH + 'vale.jpg'))),
                ),
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
      //TODO ABILITARE BOTTONE O MENU
    });
  }

  void decrementPresidenteCounter(int index, TextEditingController etC) {
    setState(() {
      widget.countPresidente[index]--;
      etC.text = widget.countPresidente[index].toString();
      //TODO ABILITARE BOTTONE O MENU
    });
  }

  void onPresidenteTextChange(int index, TextEditingController etC) {
    setState(() {
      widget.countPresidente[index] = etC.text as int;
      //TODO ABILITARE BOTTONE O MENU
    });
  }

  void incrementSchiavoCounter(int index, TextEditingController etC) {
    setState(() {
      widget.countSchiavo[index]++;
      etC.text = widget.countSchiavo[index].toString();
      //TODO ABILITARE BOTTONE O MENU
    });
  }

  void decrementSchiavoCounter(int index, TextEditingController etC) {
    setState(() {
      widget.countSchiavo[index]--;
      etC.text = widget.countSchiavo[index].toString();
      //TODO ABILITARE BOTTONE O MENU
    });
  }

  void onSchiavoTextChange(int index, TextEditingController etC) {
    setState(() {
      widget.countSchiavo[index] = etC.text as int;
      //TODO ABILITARE BOTTONE O MENU
    });
  }
}
