import 'package:flutter/material.dart';
import 'package:flutter_app/ContaPunti/BaseContaPunti.dart';
import 'package:flutter_app/Components/CounterLayout.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

class BriscolaAChiamataContaPunti extends StatefulWidget
    implements BaseContaPunti {
  List<Giocatore> giocatori;
  List<double> countPunti;
  VoidCallback callback;
  List<TextEditingController> etCList = new List();


  BriscolaAChiamataContaPunti(this.giocatori, this.callback) {
    countPunti = new List();
    for (Giocatore g in giocatori) {
      double count = 0.0;
      TextEditingController etC = new TextEditingController();
      countPunti.add(count);
      etC.text = count.toString();
      etCList.add(etC);
    }
  }

  @override
  State<StatefulWidget> createState() {
    return new BriscolaAChiamataState();
  }

  @override
  bool calcolaVittoria() {
    for (double count in countPunti) if (count >= 5.0) return true;
    return false;
  }

  @override
  void updatePartita() {
    // TODO: implement updatePartita
  }
}

class BriscolaAChiamataState extends State<BriscolaAChiamataContaPunti> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 120.0),
      child: ListView.separated(
          itemBuilder: (context, index) {
            return giocatoreElement(index);
          },
          separatorBuilder: (context, index) {
            return Divider();
          },
          itemCount: widget.giocatori.length),
    );
  }

  Widget giocatoreElement(int index) {
    TextEditingController etC = widget.etCList[index];
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 16.0),
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(IMAGE_PATH + 'scanse.jpg'))),
            ),
          ),
          Center(
              child: Text(
            widget.giocatori[index].name,
            style: TextStyle(fontSize: 18),
          )),
          Spacer(),
          Center(
              child: CounterLayout.sizedLayout(etC, 30, 60, () {
            decrementCounterGiocatori(index, etC);
          }, () {
            incrementCounterGiocatori(index, etC);
          }, () {
            onTextChange(index, etC);
          })),
        ],
      ),
    );
  }

  void incrementCounterGiocatori(int index, TextEditingController etC) {
    setState(() {
      widget.countPunti[index] += 0.5;
      etC.text = widget.countPunti[index].toString();
      if (widget.calcolaVittoria()) widget.callback();
    });
  }

  void decrementCounterGiocatori(int index, TextEditingController etC) {
    setState(() {
      widget.countPunti[index] -= 0.5;
      etC.text = widget.countPunti[index].toString();
      if (widget.calcolaVittoria()) widget.callback();
    });
  }

  void onTextChange(int index, TextEditingController etC) {
    setState(() {
      widget.countPunti[index] = etC.text as double;
      if (widget.calcolaVittoria()) widget.callback();
    });
  }
}
