import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CounterButton.dart';

class CounterLayout extends StatelessWidget {
  String leftButtonText, rightButtonText;
  VoidCallback leftButtonMethod, rightButtonMethod, onTextChange;
  TextEditingController etC;

  CounterLayout(this.leftButtonText, this.rightButtonText, this.etC,
      this.leftButtonMethod, this.rightButtonMethod, this.onTextChange);

  CounterLayout.defaultLayout(this.etC, this.leftButtonMethod,
      this.rightButtonMethod, this.onTextChange) {
    leftButtonText = "-";
    rightButtonText = "+";
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CounterButton(leftButtonText, leftButtonMethod),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40,
            width: 60,
            child: TextField(
                controller: etC,
                onChanged: (value) {
                  onTextChange();
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(3)
                  //avoid to have char counter under edittxet
                ],
                decoration: InputDecoration(
                  border: InputBorder.none,
                  counterText: null,
                )),
          ),
        ),
        CounterButton(rightButtonText, rightButtonMethod)
      ],
    );
  }
}
