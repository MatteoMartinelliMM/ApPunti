import 'package:flutter/material.dart';

class CounterButton extends StatelessWidget {
  VoidCallback onTap;
  String buttonTitle;
  double width, height;

  CounterButton(this.buttonTitle, this.onTap) {
    width = 40;
    height = 40;
  }

  CounterButton.sized(this.buttonTitle, this.width, this.height, this.onTap);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Text(
            buttonTitle,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: width - 10, fontWeight: FontWeight.bold),
          ),
        ),
        width: width,
        height: height,
        decoration: BoxDecoration(
          border: Border.all(),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
