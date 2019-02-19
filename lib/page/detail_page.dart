import 'package:flutter/material.dart';
import '../page/news_page.dart';
class DetailPage extends StatefulWidget{
  final String date;
  DetailPage(this.date);

  @override
  State<StatefulWidget> createState() {
    return _DetailPageState();
  }

}

class _DetailPageState extends State<DetailPage> {

  @override
  Widget build(BuildContext context) {
    final Widget appBar = new AppBar(
      title: new Text(widget.date),
      leading: const BackButton(),
    );
    return Scaffold(
      appBar: appBar,
      body: new NewsPage(date: widget.date,),
    );
  }
}