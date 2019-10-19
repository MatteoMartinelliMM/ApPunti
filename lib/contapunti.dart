import 'package:flutter/material.dart';
import 'package:flutter_app/Components/avatarstack.dart';
import 'package:flutter_app/Model/Constants.dart';
import 'package:flutter_app/Model/Giocatore.dart';

class ContaPuntiGiocatori extends StatefulWidget {
  List<Giocatore> giocatori;

  String gioco;

  ContaPuntiGiocatori(this.giocatori, this.gioco);

  @override
  State<StatefulWidget> createState() {
    return new ContaPuntiGiocatoriState(giocatori, gioco);
  }
}

class ContaPuntiGiocatoriState extends State<ContaPuntiGiocatori> {
  List<Giocatore> giocatori;

  String gioco;

  ContaPuntiGiocatoriState(this.giocatori, this.gioco);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(gioco)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: stackavatar(getImageName(), 80.0, 80.0),
                      ),
                      GestureDetector(
                        onTap: null,
                        child: Container(
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "-",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),
                            ),
                          ),
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(),
                            shape: BoxShape.circle,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<String> getImageName() {
    List<String> imageName = new List();
    /*for(Giocatore g in giocatori)
      imageName.add(g.name);
    return imageName;*/
    imageName.add(IMAGE_PATH + "scanse.jpg");
    imageName.add(IMAGE_PATH + "vale.jpg");
    return imageName;
  }
}

String getValue(List<Giocatore> giocatori) {
  String g = "";
  for (Giocatore gi in giocatori) {
    g += gi.name + " ";
  }
  return g;
}
