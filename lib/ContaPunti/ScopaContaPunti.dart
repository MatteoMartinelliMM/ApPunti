import 'package:flutter/material.dart';
import 'package:flutter_app/Components/AvatarImage.dart';
import 'package:flutter_app/Components/CounterLayout.dart';
import 'package:flutter_app/ContaPunti/BaseContaPunti.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/FirebaseDatabaseHelper.dart';
import 'package:flutter_app/Model/Giocatore.dart';
import 'package:flutter_app/Model/Giochi/Cirulla.dart';
import 'package:flutter_app/Model/Giochi/Scopa.dart';

class ScopaContaPunti extends StatefulWidget implements BaseContaPunti {
  List<Giocatore> giocatori;

  VoidCallback callback;

  String gioco;
  List<int> counters;
  List<TextEditingController> etCList;
  bool p21;
  bool p11;

  ScopaContaPunti(this.giocatori, this.gioco, this.callback) {
    counters = new List();
    etCList = new List();
    for (Giocatore g in giocatori) {
      int count = 0;
      counters.add(count);
      TextEditingController etc = new TextEditingController();
      etc.text = count.toString();
      etCList.add(etc);
    }
    p21 = true;
    p11 = false;
  }

  @override
  State<StatefulWidget> createState() {
    return new ScopaContaPuntiState();
  }

  @override
  bool calcolaVittoria() {
    switch (gioco) {
      case SCOPA:
        for (int count in counters)
          if ((p21 && count > 21) || (p11 && count > 11)) return true;
        return false;
      case CIRULLA:
        for (int count in counters)
          if ((p21 && count > 51) || (p11 && count > 31)) return true;
        return false;
      case BRISCOLA:
        for (int count in counters) if (count > 0) return true;
        return false;
    }
  }

  @override
  void updatePartita() {
    List<int> ordered = new List();
    ordered = counters;
    ordered.sort((a, b) => b.compareTo(a));
    for (Giocatore g in giocatori) {
      switch (gioco) {
        case SCOPA:
          (g.gioco as Scopa).puntiFatti += counters[giocatori.indexOf(g)];
          break;
        case BRISCOLA:
          break;
        case CIRULLA:
          (g.gioco as Cirulla).puntiFatti += counters[giocatori.indexOf(g)];
          break;
      }
      g.gioco.partiteGiocate++;
      if (giocatori.indexOf(g) == counters.indexOf(ordered[0]))
        g.gioco.partiteVinte++;
    }
    FirebaseDatabaseHelper fbDbH = new FirebaseDatabaseHelper();
    fbDbH.updateGioco(giocatori, gioco);
  }
}

class ScopaContaPuntiState extends State<ScopaContaPunti> {
  List<Widget> getGiocatoriBody() {
    List<Widget> toReturn = new List();
    toReturn.add(getCheckBoxPunti());
    for (Giocatore g in widget.giocatori) {
      toReturn.add(Card(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Row(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AvatarImage(
                      widget.giocatori[widget.giocatori.indexOf(g)].url,
                      80,
                      80),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CounterLayout.defaultLayout(
                      widget.etCList[widget.giocatori.indexOf(g)], () {
                    setState(() {
                      widget.counters[widget.giocatori.indexOf(g)]--;
                      widget.etCList[widget.giocatori.indexOf(g)].text = widget
                          .counters[widget.giocatori.indexOf(g)]
                          .toString();
                      widget.callback();
                    });
                  }, () {
                    setState(() {
                      widget.counters[widget.giocatori.indexOf(g)]++;
                      widget.etCList[widget.giocatori.indexOf(g)].text = widget
                          .counters[widget.giocatori.indexOf(g)]
                          .toString();
                      if (widget.calcolaVittoria()) widget.callback();
                    });
                  }, () {
                    setState(() {
                      widget.counters[widget.giocatori.indexOf(g)] =
                          widget.etCList[widget.giocatori.indexOf(g)] as int;
                      widget.callback();
                    });
                  }),
                )
              ],
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 25, bottom: 8.0),
                  child: Text(
                    g.name,
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ],
        ),
      ));
      if (widget.giocatori.last.name != g.name)
        toReturn.add(Image.asset('assets/image/vs_small.png'));
    }
    return toReturn;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: getGiocatoriBody(),
      ),
    );
  }

  Opacity getCheckBoxPunti() {
    return Opacity(
      opacity: widget.gioco == BRISCOLA ? 0.0 : 1.0,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text("Punti vittoria",
                      style: TextStyle(fontSize: 25),
                      textAlign: TextAlign.center),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: widget.p11,
                    onChanged: (bool value) {
                      setState(() {
                        widget.p11 = value;
                        widget.p21 = !value;
                        if (widget.calcolaVittoria()) widget.callback();
                      });
                    },
                  ),
                  Text(widget.gioco == SCOPA ? '11 punti' : '31 punti')
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Checkbox(
                    value: widget.p21,
                    onChanged: (bool value) {
                      setState(() {
                        widget.p21 = value;
                        widget.p11 = !value;
                        if (widget.calcolaVittoria()) widget.callback();
                      });
                    },
                  ),
                  Text(widget.gioco == SCOPA ? '21 punti' : '51 punti')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
