import 'package:flutter/material.dart';

class GankTitleView extends StatelessWidget{
  final String _title;
  GankTitleView(this._title);
  @override
  Widget build(BuildContext context) {
   return new Container(
      padding: const EdgeInsets.all(8.0),
     child: new Text(_title,
     style: const TextStyle(fontSize: 24.0,fontWeight: FontWeight.bold)),
    );
  }

}