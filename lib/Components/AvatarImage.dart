import 'package:flutter/material.dart';
import 'package:flutter_app/Model/Constants.dart';

class AvatarImage extends StatelessWidget {
  String url;

  double height, width;

  AvatarImage(this.url, this.width, this.height);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
        child: getUserImage(url, height, width));
  }

  Widget getUserImage(String url, double height, double width) {
    if (url != null && url.isNotEmpty)
      return FadeInImage(
          fit: BoxFit.fill,
          height: height,
          width: width,
          placeholder: AssetImage(IMAGE_PATH + 'progress.gif'),
          image: NetworkImage(url));
    else
      return Image.asset(
        IMAGE_PATH + 'defuser.png',
        height: height,
        width: width,
        fit: BoxFit.fill,
      );
  }
}
