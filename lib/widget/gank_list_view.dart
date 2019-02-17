import 'package:flutter/material.dart';
import '../model/gank_info.dart';
import '../widget/icon_and_text.dart';
import '../widget/placeholder_image_view.dart';

class GankListView extends StatelessWidget {
  final GankInfo gankInfo;
  final int currentIndex;
  final int dataCount;

  //是否支持侧滑删除
  final bool dismissible;
  final Function(int, GankInfo) onDismissed;

  GankListView(this.gankInfo,
      {Key key,
      @required this.currentIndex,
      @required this.dataCount,
      this.dismissible = false,
      this.onDismissed})
      : super(key: key);
  final double _defaultSpacing = 8.0;

  Widget _buildText() => new Text(this.gankInfo.desc,
      style: new TextStyle(
          fontSize: 18.0,
          color: Colors.blueGrey[800],
          fontWeight: FontWeight.bold));

  ///底部布局
  Widget _buildBottom(BuildContext context) => Row(
        children: <Widget>[
          new IconAndText(Icons.person, this.gankInfo.who),
          new SizedBox(
            width: _defaultSpacing,
          ),
          new IconAndText(
              Icons.update, getTimeDuration(this.gankInfo.publishedAt))
        ],
      );

  ///构建缩略图
  Widget _buildPreView() =>
      this.gankInfo.images == null || this.gankInfo.images.isEmpty
      ? new Container()
          :new ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: new PlaceholderImageView(
          this.gankInfo.images[0].replaceAll('large', 'thumbanil'),
          width: 100.0,
          height: 100.0,
        ),
      );

  Widget _buildContent(BuildContext context){
    final borderRadius = const BorderRadius.all(Radius.circular(4.0));
    return new Material(
      borderRadius: borderRadius,
        child: new InkWell(
          borderRadius: borderRadius,
          child: new Container(
            padding: new EdgeInsets.all(_defaultSpacing),
            child: new Row(
              children: <Widget>[
                new Expanded(child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                ))
              ],
            ),
          ),
        ),
    )
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }

  String getTimeDuration(String publishedAt) {}
}
