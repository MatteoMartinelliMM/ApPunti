import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';

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
        child: buildButtonLabel(),
        width: width,
        height: height,
        decoration: buildDecorationOrImage(),
      ),
    );
  }

  BoxDecoration buildDecorationOrImage() {
    if (buttonTitle.contains(IMAGE_PATH)) {
      return BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              image: AssetImage(buttonTitle), fit: BoxFit.fill));
    }
    return BoxDecoration(
      border: Border.all(),
      shape: BoxShape.circle,
    );
  }

  Align buildButtonLabel() {
    if (!buttonTitle.contains(IMAGE_PATH))
      return Align(
        alignment: Alignment.center,
        child: Text(
          buttonTitle,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: width - 10, fontWeight: FontWeight.bold),
        ),
      );
    return null;
  }
}
