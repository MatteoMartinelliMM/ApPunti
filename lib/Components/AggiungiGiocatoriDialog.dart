import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Model/FirebaseDatabaseHelper.dart';

import 'AvatarImage.dart';

class AggiungiGiocatoriDialog extends StatefulWidget {
  String name;
  String tel;
  List<TextEditingController> etcList;
  FocusNode focusNode;
  FirebaseDatabaseHelper fbdh;

  AggiungiGiocatoriDialog(this.name) {
    focusNode = new FocusNode();
    fbdh = new FirebaseDatabaseHelper();
  }

  @override
  State<StatefulWidget> createState() {
    return new AggiungiGiocatoriDialogState();
  }
}

class AggiungiGiocatoriDialogState extends State<AggiungiGiocatoriDialog> {
  ObjectKey etCListKey, fbdhKey, nameKey, focusNodeKey;

  @override
  Widget build(BuildContext context) {
    widget.etcList = etCListKey.value;
    return SimpleDialog(
      title: const Text('Aggiungi nuovo giocatore'),
      elevation: 20,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Align(
            alignment: Alignment.topCenter,
            child: AvatarImage(null, 100, 100),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.etcList[0],
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
              border: OutlineInputBorder(),
              labelText: 'Nome giocatore',
            ),
            onSubmitted: (value) {
              setState(() {
                FocusScope.of(context).requestFocus(widget.focusNode);
                widget.etcList[0].text = value;
                widget.name = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: widget.etcList[1],
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 20.0),
              border: OutlineInputBorder(),
              labelText: 'Numero di telefono',
            ),
            onSubmitted: (value) {
              setState(() {
                widget.etcList[1].text = value;
                widget.tel = value;
                //                                                                                                                                                             SystemChannels.textInput.invokeMethod('TextInput.hide');
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: RaisedButton(
                      color: Colors.grey,
                      child: Text('Annulla'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 4.0),
                    child: RaisedButton(
                      child: Text('Crea'),
                      onPressed: !allFieldSetted()
                          ? null
                          : () {
                              Navigator.of(context).pop();
                              widget.fbdh.createGiocatore(
                                  widget.etcList[0].text,
                                  widget.etcList[1].text);
                            },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  bool allFieldSetted() {
    for (TextEditingController e in widget.etcList)
      if (e == null || e.text == null || e.text.isEmpty) return false;
    return true;
  }

  @override
  void initState() {
    widget.etcList = new List();
    widget.etcList.add(new TextEditingController());
    widget.etcList[0].text = widget.name;
    widget.etcList.add(new TextEditingController());
    widget.etcList[1].text = widget.tel;
    etCListKey = new ObjectKey(widget.etcList);
  }
}
