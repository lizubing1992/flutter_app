import 'package:flutter/material.dart';
import 'package:flutter_app/model/today_indfo.dart';
import '../model/gank_info.dart';
import '../manager/bus_manager.dart';
import '../event/update_news_date_event.dart';
import '../util/data_util.dart';
import '../page/photo_gallery_page.dart';
import '../widget/gank_pic_view.dart';
import '../widget/gank_title_view.dart';
import '../widget/gank_list_view.dart';

class NewsPage extends StatefulWidget {
  final String date;

  NewsPage({this.date = ''});

  @override
  State<StatefulWidget> createState() {
    return _NewsPageState();
  }
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
  String _currentDate = '';
  String _girlImage;
  Map<String, List<GankInfo>> _itemData = new Map();
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _currentDate = widget.date;
    _registerBusEvent();
    _initController();
    _loadData();
  }

  Future<void> _loadData() async {
    if (_currentDate.isEmpty) {
      await DataUtil.getLastDayData()
          .then((todayInfo) => _setTodayInfo(todayInfo));
    } else {
      await DataUtil.getSpecialDayData(_currentDate)
          .then((todayInfo) => _setTodayInfo(todayInfo));
    }
  }

  void _initController() {
    _scrollController = new ScrollController();
  }

  /// 日期选择刷新界面
  void _registerBusEvent() {
    BusManager.bus
        .on<UpdateNewsDateEvent>()
        .listen((UpdateNewsDateEvent event) {
      setState(() {
        _currentDate = event.date;
          _onRefresh();
      });
    });
  }

  Future<void> _onRefresh() async {
    _itemData.clear();
    await _loadData();
    return null;
  }

  void _itemPhotoTap(List<String> images) => Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => new PhotoGalleryPage(images)));

  List<Widget> _buildItem() {
    List<Widget> _widgets = [];
    //妹子图
    _widgets.add(new GankPicView(_girlImage,
        onPhotoTap: () => _itemPhotoTap([_girlImage])));
    _itemData.forEach((title, gankInfo) {
      _widgets.add(new GankTitleView(title));
      for (int i = 0; i < gankInfo.length; i++) {
        _widgets.add(new GankListView(gankInfo[i],
            currentIndex: i, dataCount: gankInfo.length));
      }
    });
    return _widgets;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return _itemData.isEmpty?
    new Center(child: const CircularProgressIndicator(),)
    : new Container(
      color: Theme.of(context).backgroundColor,
      child: new RefreshIndicator(
          child: new ListView(
            children: _buildItem(),
            controller: _scrollController,
          ),
          onRefresh: _onRefresh),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void _setTodayInfo(TodayInfo todayInfo) {
    setState(() {
      _girlImage = todayInfo.girlImage;
      _itemData = todayInfo.itemData;
    });
  }
}
