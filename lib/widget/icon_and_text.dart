import 'package:flutter/material.dart';

class IconAndText extends StatelessWidget {
  final double size;
  final IconData iconData;
  final String text;
  final int color;

  IconAndText(this.iconData, this.text,
      {this.size = 16.0, this.color = 0xFF546E7A});

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Icon(this.iconData,size: this.size,color:new Color( this.color),),
        new SizedBox(width: 5.0,),
        //这是啥写法
        new Text(text ??'',style: new TextStyle(fontSize: this.size),)
      ],
    );
  }
}
