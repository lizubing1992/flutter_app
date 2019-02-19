import 'package:flutter/material.dart';
import '../model/gank_info.dart';
import '../model/empty_view_status.dart';
import '../manager/bus_manager.dart';
import '../event/update_favorites_event.dart';
import '../manager/favorite_manager.dart';
import '../constant/strings.dart';
import '../widget/gank_list_view.dart';
import '../widget/smart_list_view.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FavoritesPageState();
  }
}

class _FavoritesPageState extends State<FavoritesPage>
    with AutomaticKeepAliveClientMixin {
  List<GankInfo> _gankInfo = [];

  //默认展示无数据
  EmptyViewStatus status = EmptyViewStatus.noData;

  @override
  void initState() {
    super.initState();
    _registerBusEvent();
    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    return new SmartListView(datas: this._gankInfo,
        emptyViewStatus: this.status,
        refreshEnable: false,
        loadMoreEnable: false,
        renderList: (index) => _renderList(index));
  }

  @override
  bool get wantKeepAlive => true;

  void _registerBusEvent() async {
    BusManager.bus
        .on<UpdateFavoritesEvent>()
        .listen((updateFavoritesEvent) => _loadData());
  }

  Future<void> _loadData() async {
    //直接从数据库里面那数据
    await FavoriteManager.find({}).then((data) {
      setState(() {
        _gankInfo =
            data.map<GankInfo>((data) => GankInfo.fromJson(data)).toList();
      });
    });
  }

  /// 删除item
  void _onItemDismissed(int currentIndex, GankInfo currentGankInfo) async {
    int count = await FavoriteManager.delete(currentGankInfo);
    if (count > 0) {
      setState(() {
        _gankInfo.remove(currentGankInfo);
        _updateEmptyViewStatus();
      });
      Scaffold.of(context).hideCurrentSnackBar();
      Scaffold.of(context).showSnackBar(new SnackBar(
        content: const Text(StringValues.DELETE_SUCCESS),
        action: new SnackBarAction(
            label: StringValues.RETRACT,
            onPressed: () async {
              await FavoriteManager.insert(currentGankInfo).then((objectId) {
                setState(() {
                  _gankInfo.insert(currentIndex, currentGankInfo);
                  _updateEmptyViewStatus();
                });
              });
            }),
      ));
    }
  }

  Widget _renderList(int index) => new GankListView(_gankInfo[index],
      currentIndex: index,
      dataCount: _gankInfo.length,
      dismissible: true,
      onDismissed: _onItemDismissed);

  void _updateEmptyViewStatus() {
    status =
        _gankInfo.isEmpty ? EmptyViewStatus.noData : EmptyViewStatus.hasData;
  }
}
