import 'package:flutter/material.dart';
import '../util/time_util.dart';

class HistoryListView extends StatelessWidget {
  final String date;
  final String currentDate;
  final Function(String) onTap;

  HistoryListView(this.date, this.currentDate, {Key key, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color dayColor =
        date == currentDate ? Theme.of(context).accentColor : Colors.grey[800];
    final Color textColor = date == currentDate
        ? Theme.of(context).accentColor
        : Theme.of(context).primaryColor;

    final TextStyle dayStyle = new TextStyle(
        color: dayColor, fontSize: 16.0, fontWeight: FontWeight.bold);

    final TextStyle textStyle = new TextStyle(
      color: textColor,
      fontSize: 12.0,
    );
    return new InkWell(
      child: new Container(
        padding: const EdgeInsets.all(8.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Row(
              children: <Widget>[
                new Text(getDay(date),style: dayStyle,),
                new SizedBox(width: 3.0,),
                new Text(getWeekDay(date),style: textStyle,)
              ],
            ),
            new Text(getMonth(date),style: textStyle,)
          ],
        ),
      ),
      onTap: ()=>this.onTap(this.date),
    );
  }
}
