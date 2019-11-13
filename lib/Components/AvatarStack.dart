import 'package:flutter/material.dart';
import 'package:flutter_app/Components/AvatarImage.dart';

class stackavatar extends StatelessWidget {
  List<String> imageName;
  double avatarHeight, avatarWidth, paddingOffset;

  stackavatar(this.imageName, this.avatarHeight, this.avatarWidth) {
    paddingOffset = avatarWidth / 2;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(fit: StackFit.loose, children: getAvatars());
  }

  Widget buildSingleAvatar(String imageName) {
    return AvatartImage(imageName, 80, 80);
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
                child: buildSingleAvatar(imageName[i])));
      }
      avarList.add(avatar);
    }
    return avarList;
  }
}
