import 'package:flutter/material.dart';
import '../model/history_content_info.dart';
import '../model/empty_view_status.dart';
import '../util/data_util.dart';
import '../page/detail_page.dart';
import '../widget/load_more_view.dart';
import '../widget/history_content_list_item.dart';
import '../widget/smart_list_view.dart';

class HistoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HistoryPageState();
  }
}

class _HistoryPageState extends State<HistoryPage> {
  final int _pageCount = 20;
  int _pageNum = 1;
  bool _isLoadMore = false;
  bool _hasMore = false;
  List<HistoryContentInfo> _historyList = [];
  ScrollController _scrollController;

  ///默认没有数据
  EmptyViewStatus status = EmptyViewStatus.loading;

  @override
  void initState() {
    super.initState();
    _initController();
    _initLoad();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Widget appBar = new AppBar(
      title: const Text('干货历史'),
      leading: const BackButton(),
    );

    final Widget body = new SmartListView(datas: _historyList,
        emptyViewStatus: status,
        onRrfresh: () async => _onRefresh(),
        onLoadMore: () async => _onLoadMore(),
        renderList: (index) => _renderList(context,index));
    return new Scaffold(appBar: appBar,body: body,);
  }

  void _initController() {
    _scrollController = new ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _onLoadMore();
      }
    });
  }

  Future<void> _initLoad() async {
    if (_isLoadMore) {
      _pageNum += 1;
    } else {
      _pageNum = 1;
    }
    await DataUtil.getHistoryContentData(_pageNum, count: _pageCount)
        .then((result) {
      setState(() {
        _historyList.addAll(result);
        _hasMore = result.length >= _pageCount;
        status = _historyList.isEmpty && _pageNum == 1
            ? EmptyViewStatus.noData
            : EmptyViewStatus.hasData;
      });
    });
  }

  Future<void> _onLoadMore() async {
    if (_hasMore) {
      _isLoadMore = false;
      await _initLoad();
    }
  }

  Future<void> _onRefresh() async {
    _historyList.clear();
    _isLoadMore = true;
    await _initLoad();
  }

  void _itemTap(BuildContext context, String date) =>
      Navigator.of(context)
          .push(
          new MaterialPageRoute(builder: (context) => new DetailPage(date)));

  Widget _renderList(BuildContext context, int index) {
    if (index == _historyList.length) {
      return new LoadMoreView(_hasMore);
    } else {
      return new HistoryContentListItem(
        _historyList[index],
        onTap: _itemTap,
      );
    }
  }
}
