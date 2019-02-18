import 'package:flutter/material.dart';
import '../constant/strings.dart';
import '../model/empty_view_status.dart';

/// 加载总体的布局
class EmptyView extends StatelessWidget {
  final Widget child;
  final String image;
  final String remark;
  final EmptyViewStatus status;

  EmptyView(
      {Key key,
      @required this.child,
      this.image,
      this.remark = StringValues.EMPTY_NO_DATA_REMARK,
      @required this.status})
      : super(key: key);

  Widget _buildLoadingView() => new Center(
        child: const CircularProgressIndicator(),
      );

  Widget _buildNoDataView() => new Center(
        child: new Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            new Text(
              this.remark,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      );

  @override
  Widget build(BuildContext context) {
    switch (this.status) {
      case EmptyViewStatus.loading:
        return _buildLoadingView();
        break;
      case EmptyViewStatus.hasData:
        return this.child;
        break;
      case EmptyViewStatus.noData:
        return _buildNoDataView();
        break;
    }
    return _buildLoadingView();
    ;
  }
}
