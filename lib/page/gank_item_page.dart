import 'package:flutter/material.dart';
import '../model/gank_info.dart';
import '../model/empty_view_status.dart';
import '../util/data_util.dart';
import '../widget/load_more_view.dart';
import '../widget/gank_list_view.dart';
import '../widget/smart_list_view.dart';

class GankItemPage extends StatefulWidget {
  final String categoryName;

  //是不是进行查询
  final String query;

  GankItemPage(this.categoryName, {this.query = ''});

  @override
  State<StatefulWidget> createState() {
    return _GankItemPageState();
  }
}

class _GankItemPageState extends State<GankItemPage>
    with AutomaticKeepAliveClientMixin {
  int _pageNo = 1;
  bool _isLoadMore = false;
  bool _hasMore = false;
  List<GankInfo> _gankInfos = [];
  ScrollController _scrollController;

  //默认Loading
  EmptyViewStatus _emptyViewStatus = EmptyViewStatus.loading;

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
        //底部加载更多
        _onLoadMore();
      }
    });
  }

  Future<void> _loadData() async {
    _isLoadMore ? _pageNo++ : _pageNo = 1;
    List<GankInfo> result = widget.query.isNotEmpty
        //全部数据
        ? await DataUtil.searchData(widget.query, _pageNo)
        // 分类数据
        : await DataUtil.getCategoryData(widget.categoryName, _pageNo);
    //页面展示
    if (this.mounted) {
      setState(() {
        _gankInfos.addAll(result);
        _hasMore = result.length >= 20;
        _emptyViewStatus = _gankInfos.isEmpty && _pageNo == 1
            ? EmptyViewStatus.noData
            : EmptyViewStatus.hasData;
      });
    }
  }

  Future<void> _onRefresh() async {
    _isLoadMore = false;
    _gankInfos.clear();
    await _loadData();
    return null;
  }

  Future<void> _onLoadMore() async {
    _isLoadMore = true;
    await _loadData();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Widget _renderList(int index) {
    if (index == _gankInfos.length) {
      return new LoadMoreView(_hasMore);
    }
    return GankListView(
      _gankInfos[index],
      currentIndex: index,
      dataCount: _gankInfos.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new SmartListView(
        datas: this._gankInfos,
        emptyViewStatus: this._emptyViewStatus,
        renderList: (index) =>this._renderList(index),
        onRrfresh: () async => this._onRefresh(),
        onLoadMore: () async => this._onLoadMore(),);
  }
}
