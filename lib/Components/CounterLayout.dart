import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'CounterButton.dart';

class CounterLayout extends StatelessWidget {
  String leftButtonText, rightButtonText;
  VoidCallback leftButtonMethod, rightButtonMethod, onTextChange;
  TextEditingController etC;
  double height, width;

  CounterLayout(this.leftButtonText, this.rightButtonText, this.etC,
      this.leftButtonMethod, this.rightButtonMethod, this.onTextChange) {
    height = 40;
    width = 80;
  }

  CounterLayout.defaultLayout(this.etC, this.leftButtonMethod,
      this.rightButtonMethod, this.onTextChange) {
    leftButtonText = "-";
    rightButtonText = "+";
    height = 40;
    width = 80;
  }

  CounterLayout.sizedLayout(this.etC, double height, double width,
      this.leftButtonMethod, this.rightButtonMethod, this.onTextChange) {
    leftButtonText = "-";
    rightButtonText = "+";
    this.height = height;
    this.width = width;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CounterButton.sized(leftButtonText, height, height, leftButtonMethod),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: height,
            width: width,
            child: TextField(
                controller: etC,
                textInputAction: TextInputAction.done,
                onSubmitted: (value) {
                  onTextChange();
                },
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: height - 10, fontWeight: FontWeight.bold),
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
        CounterButton.sized(rightButtonText, height, height, rightButtonMethod)
      ],
    );
  }
}
