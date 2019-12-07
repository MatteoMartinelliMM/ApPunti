import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Model/DatabaseProvider.dart';
import 'package:flutter_app/Model/Giochi/BriscolaAChiamata.dart';

import 'Model/FirebaseDatabaseHelper.dart';
import 'Model/Giocatore.dart';
import 'Model/Giochi/Asse.dart';
import 'Model/Giochi/Briscola.dart';
import 'Model/Giochi/Cirulla.dart';
import 'Model/Giochi/Gioco.dart';
import 'Model/Giochi/Presidente.dart';
import 'Model/Giochi/Scopa.dart';
import 'Model/Giochi/ScoponeGioco.dart';
import 'SelezionaGioco.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.giocatori);

  List<Giocatore> giocatori;
  TextEditingController user, numero;
  FocusNode focusNode;
  bool canLogin = false;

  bool isError = false;
  FirebaseDatabaseHelper fbdh;

  @override
  State<StatefulWidget> createState() {
    return LogninPageState();
  }
}

class LogninPageState extends State<LoginPage> {
  ObjectKey cKey, uKey, nKey;

  @override
  Widget build(BuildContext context) {
    widget.user = uKey.value;
    widget.numero = nKey.value;
    widget.canLogin = cKey.value;
    return Scaffold(
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.next,
                controller: widget.user,
                onSubmitted: (value) {
                  enableLoginBtn();
                  FocusScope.of(context).requestFocus(widget.focusNode);
                },
                onChanged: (newValue) {
                  enableLoginBtn();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  border: OutlineInputBorder(),
                  labelText: 'Username',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: widget.numero,
                textCapitalization: TextCapitalization.words,
                textInputAction: TextInputAction.done,
                focusNode: widget.focusNode,
                onSubmitted: (value) {
                  enableLoginBtn();
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                onChanged: (newValue) {
                  enableLoginBtn();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
                  border: OutlineInputBorder(),
                  labelText: 'Numero di telefono',
                ),
              ),
            ),
            RaisedButton(
              onPressed: !widget.canLogin
                  ? null
                  : () {
                      setState(() {
                        int indexOfUser = userExists(widget.user.text);
                        if (indexOfUser != -1) {
                          Giocatore giocatore = widget.giocatori[indexOfUser];
                          if (giocatore.numero == widget.numero.text) {
                            addUserOnDbAndGoToHome(giocatore, context, true);
                          } else
                            widget.isError = true;
                        } else
                          widget.isError = true;
                      });
                    },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            Visibility(
              visible: widget.isError,
              child: RaisedButton(
                  color: Colors.red,
                  onPressed: () {
                    Giocatore giocatore = new Giocatore(widget.user.text);
                    giocatore.numero = widget.numero.text;
                    widget.fbdh
                        .createGiocatore(widget.user.text, widget.numero.text);
                    addUserOnDbAndGoToHome(giocatore, context, false);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Registrati',
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }

  void addUserOnDbAndGoToHome(
      Giocatore giocatore, BuildContext context, bool fromLogin) {
    DatabaseProvider db = new DatabaseProvider();
    db.addUser(giocatore).then((id) {
      widget.isError = false;
      if (fromLogin) {
        widget.fbdh.getAllGiochi(giocatore.name).then((giochi) {
          db.insertAllGiochi(giochi, giocatore.name).then((id) {
            Navigator.of(context).pushReplacement(new MaterialPageRoute(
                builder: (BuildContext context) => new HomePage(giocatore)));
          });
        });
      } else {
        List<Gioco> giochi = new List();
        giochi.add(new Scopa.giocoForFb());
        giochi.add(new ScoponeGioco.giocoForFb());
        giochi.add(new Briscola.giocoForFb());
        giochi.add(new BriscolaAChiamata.giocoForFb());
        giochi.add(new Cirulla.giocoForFb());
        giochi.add(new Asse.giocoForFb());
        giochi.add(new Presidente.giocoForFb());
        db.insertAllGiochi(giochi, giocatore.name).then((id) {
          Navigator.of(context).pushReplacement(new MaterialPageRoute(
              builder: (BuildContext context) => new HomePage(giocatore)));
        });
      }
    });
  }

  int userExists(String name) {
    for (Giocatore g in widget.giocatori) {
      if (g.name == name) return widget.giocatori.indexOf(g);
    }
    return -1;
  }

  void enableLoginBtn() {
    setState(() {
      widget.canLogin =
          widget.user.text.isNotEmpty && widget.numero.text.isNotEmpty;
      cKey = new ObjectKey(widget.canLogin);
    });
  }

  @override
  void initState() {
    widget.user = new TextEditingController();
    widget.numero = new TextEditingController();
    uKey = new ObjectKey(widget.user);
    nKey = new ObjectKey(widget.numero);
    cKey = new ObjectKey(widget.canLogin);
    widget.focusNode = new FocusNode();
    widget.fbdh = new FirebaseDatabaseHelper();
  }
}
