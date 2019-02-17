import 'package:flutter/material.dart';

class HistoryDateView extends StatelessWidget {
  final double opacity;

  //日期列表
  final List<String> historyDates;

  //当前选中的日期
  final String curentDate;

  // item点击回调
  final Function(String) onTap;


  HistoryDateView({Key key, @required this.opacity,
    @required this.historyDates, @required this.curentDate, this.onTap})
      :super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

}