import 'package:flutter/material.dart';

class stackavatar extends StatelessWidget {
  List<String> imageName;
  double avatarHeight, avatarWidth, paddingOffset;

  stackavatar(this.imageName, this.avatarHeight, this.avatarWidth) {
    paddingOffset = avatarWidth / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.loose,
      children: getAvatars()
    );
  }

  Container buildSingleAvatar(String imageName) {
    return Container(
      height: 80,
      width: 80,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage(
                  imageName))),
    );
  }

  List<Widget> getAvatars() {
    List<Widget> avarList = new List();
    for (int i = 0; i < imageName.length; i++) {
      Widget avatar;
      if (i == 0) {
        avatar = buildSingleAvatar(imageName[i]);
      } else {
        avatar = Padding(
            padding: EdgeInsets.only(left: paddingOffset * i),
            child: Align(
                alignment: Alignment.centerRight,
                child:
                buildSingleAvatar(imageName[i])));
      }
      avarList.add(avatar);
    }
    return avarList;
  }
}