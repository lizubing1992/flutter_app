import 'package:flutter/material.dart';
import '../model/gank_info.dart';
import '../widget/icon_and_text.dart';
import '../widget/placeholder_image_view.dart';
import '../util/time_util.dart';
import '../page/article_page.dart';

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

  Widget _buildText() =>
      new Text(this.gankInfo.desc,
          style: new TextStyle(
              fontSize: 18.0,
              color: Colors.blueGrey[800],
              fontWeight: FontWeight.bold));

  ///底部布局
  Widget _buildBottom(BuildContext context) =>
      Row(
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
          : new ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4.0)),
        child: new PlaceholderImageView(
          this.gankInfo.images[0].replaceAll('large', 'thumbanil'),
          width: 100.0,
          height: 100.0,
        ),
      );

  /// 构建内容
  Widget _buildContent(BuildContext context) {
    final borderRadius = const BorderRadius.all(Radius.circular(4.0));
    return new Material(
      borderRadius: borderRadius,
      child: new InkWell(
        borderRadius: borderRadius,
        child: new Container(
          padding: new EdgeInsets.all(_defaultSpacing),
          child: new Row(
            children: <Widget>[
              new Expanded(
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _buildText(),
                    new SizedBox(
                      height: _defaultSpacing,
                    ),
                    _buildBottom(context)
                  ],
                ),
              ),
              new SizedBox(
                width: _defaultSpacing,
              ),
              _buildPreView()
            ],
          ),
        ),
        onTap: () => _onItemTap(context),
      ),
    );
  }

  Widget _buildLayout(BuildContext context) {
    final double topSpacing = this.currentIndex == 0 ? _defaultSpacing : 0.0;
    final double bottomSpacing =
    this.currentIndex == this.dataCount ? 0.0 : _defaultSpacing;
    return new Card(
      margin: new EdgeInsets.only(
          left: _defaultSpacing,
          right: _defaultSpacing,
          top: topSpacing,
          bottom: bottomSpacing
      ),
      child: _buildContent(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return this.dismissible?
    new Dismissible(key: new Key(this.gankInfo.itemId),
        child: _buildLayout(context),
    onDismissed: (decoration){
      this.onDismissed(this.currentIndex,this.gankInfo);
    }):_buildLayout(context);
  }


  void _onItemTap(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
    new ArticlePage(this.gankInfo)));
  }
}
