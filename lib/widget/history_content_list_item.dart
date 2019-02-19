import 'package:flutter/material.dart';
import '../model/history_content_info.dart';
import '../util/display_util.dart';
import '../widget/placeholder_image_view.dart';

class HistoryContentListItem extends StatelessWidget {
  final HistoryContentInfo contentInfo;
  final Function(BuildContext, String) onTap;

  HistoryContentListItem(this.contentInfo, {Key key, this.onTap})
      : super(key: key);

  final double _spacing = 8.0;
  final double _itemHeight = 200.0;

  List<Widget> _buildContent(BuildContext context) {
    final double opacity = 0.3;
    final double itemWidth = DisPlayUtil.getScreenWidth(context);

    List<Widget> widgetList = [];

    widgetList.add(
        new PlaceholderImageView(this.contentInfo.thumb, width: itemWidth,));

    widgetList.add(new Opacity(opacity: opacity, child: new Container(
      color: Colors.black,
    ),));

    widgetList.add(new Align(
      alignment: Alignment.centerLeft,
      child: Padding(padding: const EdgeInsets.all(8.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(this.contentInfo.title, style: const TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold
            ),),
            new SizedBox(height: _spacing,),
            new Text(
              this.contentInfo.publishedAt,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16.0
              ),
            )

          ],
        ),),
    ));

    widgetList.add(new Material(
      type: MaterialType.transparency,
      child: new InkWell(
        onTap: () {
          this.onTap(context, this.contentInfo.publishedAt);
        },
      ),
    ));

    return widgetList;
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      height: _itemHeight,
      margin: new EdgeInsets.only(top: _spacing,left: _spacing,right: _spacing),
      child: new Card(
        margin: const EdgeInsets.all(0.0),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: new Stack(
          children: _buildContent(context),
        ),
      ),
    );
  }
}
