import 'package:flutter/material.dart';
import '../manager/user_manager.dart';
import '../manager/favorite_manager.dart';
import '../model/user_info.dart';
import '../manager/bus_manager.dart';
import '../event/update_user_info_event.dart';
import '../util/data_util.dart';
import '../model/bottom_tab.dart';
import '../event/update_news_date_event.dart';
import '../widget/placeholder_image_view.dart';
import '../page/submit_page.dart';
import '../page/search_page.dart';
import '../page/login_page.dart';
import '../constant/strings.dart';
import '../page/info_page.dart';
import '../widget/history_date_view.dart';
import '../page/news_page.dart';
import '../page/category_page.dart';
import '../page/mei_zi_page.dart';
import '../page/favorites_page.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HoPageState();
  }
}

class _HoPageState extends State<HomePage> {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey();

  int _tabIndex = 0;
  PageController _pageController;

  double _appBarElevation = 4.0;
  double _historyOpacity = 0.0;
  String _currentDate = '';
  List<String> _historyDates = [];

  UserInfo _userInfo;

  @override
  void initState() {
    super.initState();
    _initApp();
    _initData();
    _registerBusEvent();
    _initController();
    _loadData();
  }

  ///初始化数据库
  void _initApp() async {
    await FavoriteManager.init();
  }

  ///初始化用户数据
  void _initData() async {
    _userInfo = await UserManager.getUserInfo();
  }

  /// 注册eventBus
  void _registerBusEvent() =>
      BusManager.bus
          .on<UpdateUserInfoEvent>()
          .listen((UpdateUserInfoEvent event) {
        setState(() {
          return this._userInfo = event.userInfo;
        });
      });

  ///初始化页面控制器
  void _initController() {
    _pageController = new PageController();
  }

  ///初始化数据
  Future<void> _loadData() async {
    await DataUtil.getDateList().then((resultList) {
      setState(() {
        _historyDates = resultList;
        _currentDate = _historyDates[0];
      });
    });
  }

  void _selectedTab(int index) {
    setState(() {
      _tabIndex = index;
      //page动画
      _pageController.animateToPage(_tabIndex,
          duration: new Duration(milliseconds: 300), curve: Curves.ease);
      //切换到其他分类，隐藏历史日期选择控件
      if (_historyOpacity != 0.0) {
        _historyOpacity = 0.0;
      }
      _appBarElevation = _tabIndex != TabCategory.category.index ? 4.0 : 0.0;
    });
  }

  /// 日期选择
  void _onDateRangTap() {
    setState(() {
      if (_historyOpacity == 0.0) {
        //取消AppBar底部阴影
        _appBarElevation = 0.0;
        //显示日期选择栏
        _historyOpacity = 1.0;
      } else {
        _appBarElevation = 4.0;
        _historyOpacity = 0.0;
      }
    });
  }

  ///历史日期选择栏点击事件
  void _historyDateItemTap(String date) {
    setState(() {
      if (_currentDate != date) {
        _currentDate = date;

        ///通知[NewsPage]刷新
        BusManager.bus.fire(new UpdateNewsDateEvent(_currentDate));
      }
    });
  }

  BottomNavigationBarItem _buildTab(BottomTab tab) =>
      new BottomNavigationBarItem(icon: tab.icon, title: tab.title);

  Widget _buildLeading() {
    IconButton iconButton;
    if (_tabIndex == TabCategory.news.index) {
      //新闻界面
      iconButton = new IconButton(
          icon: const Icon(Icons.date_range), onPressed: _onDateRangTap);
    } else {
      iconButton = null;
    }
    return iconButton;
  }

  List<Widget> _buildActions() =>
      [
        //添加
        new IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _onSubmitTap(context)),
        //搜索
        new IconButton(
            icon: const Icon(Icons.search), onPressed: () =>_onSearchTap(context)),
        //头像
        new IconButton(
            icon: this._userInfo == null
                ? const Icon(Icons.account_circle)
                : new CircleAvatar(
              radius: 12.0,
              child: new ClipRRect(
                borderRadius:
                const BorderRadius.all(Radius.circular(50.0)),
                child: new PlaceholderImageView(this._userInfo.avatarUl),
              ),
            ),
            onPressed: () => _onAccountTap(context))
      ];

  /// 打开[发布干货页]
  void _onSubmitTap(BuildContext context) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => new SubmitPage()));
  }

  ///打开[搜索页面]
  void _onSearchTap(BuildContext context) async {
    /// 这里用了代理
    await showSearch(context: context, delegate: SearchPage());
  }

  ///用户点击
  void _onAccountTap(BuildContext context) async {
    await UserManager.isLogin()
        ? _showBottomSheet(context)
        : Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => new LoginPage()));
  }

  ///展示退出对话框
  void _showLogoutDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              content: const Text(StringValues.LOGINOUT_DIALOG_CONTENT),
              actions: <Widget>[
                new FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text(StringValues.DIALOG_ACTION_CANCEL)),
                new FlatButton(
                    onPressed: () =>
                        Navigator.of(context)
                            .pop(StringValues.DIALOG_ACTION_CONFIRM),
                    child: const Text(StringValues.DIALOG_ACTION_CONFIRM))
              ]);
        }).then((value) async {
      if (value == StringValues.DIALOG_ACTION_CONFIRM) {
        await UserManager.removeFromLocal();
        setState(() {
          _userInfo = null;
        });

        ///页面消息展示1秒
        _scaffoldKey.currentState.showSnackBar(new SnackBar(
          content: const Text(StringValues.LOGINOUT_SUCCESS),
          duration: const Duration(milliseconds: 1000),
        ));
      }
    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) =>
        new InfoPage(
            userInfo: this._userInfo,
            onLoginOutTap: () => _showLogoutDialog(context)));
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //appbar设置
    final Widget appBar = new AppBar(
      title: new Text(_tabIndex == TabCategory.news.index
          ? _currentDate
          : StringValues.APP_NAME),
      leading: _buildLeading(),
      actions: _buildActions(),
      elevation: _appBarElevation,
    );
    //历史事件的点击
    final Widget historyView = new HistoryDateView(
        opacity: _historyOpacity,
        currentDate: _currentDate,
        historyDates: _historyDates,
        onTap: (date) => _historyDateItemTap(date));
    final Widget body = new Stack(children: <Widget>[
      new PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: _pageController,
        children: <Widget>[
          new NewsPage(),
          new CategoryPage(),
          new MeiZiPage(),
          new FavoritesPage()
        ],
      ),
      historyView
    ],);

    /// 底部tab
    final Widget bottomTabBar = new BottomNavigationBar(
      items: bottomTabs.map(_buildTab).toList(),
      type: BottomNavigationBarType.fixed,
      currentIndex: _tabIndex,
      onTap: _selectedTab,
    );
    return new Scaffold(
      key:_scaffoldKey,
      appBar: appBar,
      body: body,
      bottomNavigationBar: bottomTabBar,
    );
  }
}
