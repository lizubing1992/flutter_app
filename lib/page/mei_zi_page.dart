import 'package:flutter/material.dart';
import '../model/gank_info.dart';
import '../widget/empty_view.dart';
import '../model/empty_view_status.dart';
import '../util/data_util.dart';
import '../widget/load_more_view.dart';
import '../widget/meizi_list_item.dart';
import '../widget/smart_list_view.dart';

class MeiZiPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MeiZiPageState();
  }
}

class _MeiZiPageState extends State<MeiZiPage>
    with AutomaticKeepAliveClientMixin {
  int _pageNo = 1;
  bool _isLoadMore = false;
  bool _hasMore = false;
  List<GankInfo> _gankInfo = [];
  ScrollController _scrollController;
  EmptyViewStatus status = EmptyViewStatus.loading;

  @override
  void initState() {
    super.initState();
    _initController();
    _loadData();
  }

  @override
  bool get wantKeepAlive => true;

  void _initController() {
    _scrollController = new ScrollController();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onLoadMore();
      }
    });
  }

  Future<void> _loadData() async {
    _isLoadMore ? _pageNo++ : _pageNo = 1;
    await DataUtil.getCategoryData("福利", _pageNo).then((resultList) {
      _gankInfo.addAll(resultList);
      _hasMore = resultList.isNotEmpty;
      status = _pageNo == 1 && _gankInfo.isEmpty
          ? EmptyViewStatus.noData
          : EmptyViewStatus.hasData;
    });
  }

  Future<void> _onRefresh() async {
    _isLoadMore = false;
    _gankInfo.clear();
    await _loadData();
    return null;
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _renderList(int index) {
    if (index == _gankInfo.length) {
      return new LoadMoreView(_hasMore);
    } else {
      return new MeiZiListItem(
        _gankInfo[index].url,
        currentIndex: index,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return new SmartListView(
        datas: _gankInfo,
        emptyViewStatus: status,
        backgroudColor: Colors.white,
        onRrfresh: () async => this._onRefresh(),
        onLoadMore: () async => this._onLoadMore(),
        renderList: (index) => this._renderList(index));
  }

  Future<void> _onLoadMore() async {
    _isLoadMore = true;
    await _loadData();
  }
}
