import 'package:flutter/material.dart';
import 'package:flutter_app/Model/DatabaseProvider.dart';

import 'Model/Giocatore.dart';
import 'SelezionaGioco.dart';

class LoginPage extends StatefulWidget {
  LoginPage(this.giocatori);

  List<Giocatore> giocatori;
  TextEditingController user, numero;
  bool canLogin = false;

  bool isError = false;

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
                controller: widget.user,
                onSubmitted: (value) {
                  enableLoginBtn();
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
                onSubmitted: (value) {
                  enableLoginBtn();
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
                            DatabaseProvider db = new DatabaseProvider();
                            db.addUser(giocatore);
                            widget.isError = false;
                            Navigator.of(context).pushReplacement(
                                new MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        new HomePage(giocatore)));
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
            )
          ],
        ),
      ),
    );
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
  }
}
