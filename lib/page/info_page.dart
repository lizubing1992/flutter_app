import 'package:flutter/material.dart';
import '../model/user_info.dart';
class InfoPage extends StatelessWidget{

  final UserInfo userInfo;
  final Function onLoginOutTap;


  InfoPage({@required this.userInfo, this.onLoginOutTap})
      :assert(userInfo != null);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}