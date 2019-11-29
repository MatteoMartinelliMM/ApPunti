import 'package:flutter/material.dart';

import 'Model/Giocatore.dart';
import 'SelezionaGioco.dart';

class LoginPage extends StatefulWidget {
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
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          TextField(
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
          TextField(
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
          Spacer(
            flex: 3,
          ),
          GestureDetector(
            onTap: !widget.canLogin
                ? null
                : () {
                    setState(() {
                      if (widget.giocatori.contains(widget.user.text)) {
                        Giocatore giocatore = widget.giocatori[widget.giocatori
                            .indexOf(new Giocatore(widget.user.text))];
                        if (giocatore.numero == widget.user.text) {
                          widget.isError = false;
                          Navigator.of(context).pushReplacement(
                              new MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new HomePage(giocatore)));
                        } else {
                          widget.isError = true;
                        }
                      }
                    });
                  },
            child: Container(
                width: 200,
                color: Colors.blueAccent,
                child: Center(child: Text('Login'))),
          )
        ],
      ),
    );
  }

  void enableLoginBtn() {
    if (widget.user.text.isNotEmpty && widget.numero.text.isNotEmpty)
      setState(() {
        widget.canLogin = true;
      });
  }

  @override
  void initState() {
    widget.user = new TextEditingController();
    widget.numero = new TextEditingController();
  }
}
