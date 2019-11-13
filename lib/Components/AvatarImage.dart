import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';

class AvatartImage extends StatelessWidget {
  String url;

  double height, width;

  AvatartImage(this.url, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    ClipRRect(
        borderRadius: BorderRadius.circular(25.0),
        child: getUserImage(url, height, width));
  }

  Widget getUserImage(String url, double height, double width) {
    return url?.isNotEmpty
        ? FadeInImage(
            fit: BoxFit.fill,
            height: height,
            width: 50,
            placeholder: AssetImage(IMAGE_PATH + 'progress.gif'),
            image: NetworkImage(url))
        : Image.asset(
              IMAGE_PATH + 'defuser.png',
              height: 50,
              width: 50,
              fit: BoxFit.fill,
            ) ??
            Image.asset(IMAGE_PATH + 'defuser.png',
                height: 50, width: 50, fit: BoxFit.fill);
  }
}
