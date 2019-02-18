import 'package:flutter/material.dart';
import '../model/empty_view_status.dart';
import '../constant/strings.dart';
import '../widget/empty_view.dart';

///下来刷新，上拉加载封装
class SmartListView extends StatefulWidget {
  ///List数据
  final List<Object> datas;
  final Color backgroudColor;
  final EmptyViewStatus emptyViewStatus;
  final String emptyViewRemark;
  final bool refreshEnable;
  final bool loadMoreEnable;
  final Function(int) renderList;
  final Future<void> Function() onRrfresh;
  final Function onLoadMore;

  SmartListView({@required this.datas,
    @required this.emptyViewStatus,
    @required this.renderList,
    this.backgroudColor,
    this.emptyViewRemark = StringValues.EMPTY_NO_DATA_REMARK,
    this.refreshEnable = true,
    this.loadMoreEnable = true,
    this.onRrfresh,
    this.onLoadMore})
      : assert(datas != null),
        assert(emptyViewStatus != null),
        assert(renderList != null);

  @override
  State<StatefulWidget> createState() {
    return _SmartListViewState();
  }
}

class _SmartListViewState extends State<SmartListView> {
  ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _initController();
  }

  @override
  Widget build(BuildContext context) {
    return new EmptyView(
        child: new Container(
          color: widget.backgroudColor ?? Theme
              .of(context)
              .backgroundColor,
          child: widget.refreshEnable
              ? new RefreshIndicator(child: _buildListView(),
              onRefresh: widget.onRrfresh)
              : _buildListView(),
        ),
        status: widget.emptyViewStatus);
  }

  Widget _buildListView() =>
      ListView.builder(
          controller: _scrollController,
          itemCount:
          widget.loadMoreEnable ? widget.datas.length + 1 : widget.datas.length,
          itemBuilder: (context, index) => widget.renderList(index));

  void _initController() {
    _scrollController = new ScrollController();
    if (widget.loadMoreEnable) {
      //启用加载更多，设置监听
      _scrollController.addListener(() {
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          widget.onLoadMore();
        }
      });
    }
  }
}
