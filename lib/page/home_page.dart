import 'package:flutter/material.dart';
import '../manager/user_manager.dart';
import '../manager/favorite_manager.dart';
import '../model/user_info.dart';
import '../manager/bus_manager.dart';
import '../event/update_user_info_event.dart';
import '../util/data_util.dart';
import '../model/bottom_tab.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HoPageState();
  }
}

class _HoPageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return null;
  }

  GlobalKey<ScaffoldState> _scaffoldState = new GlobalKey();

  int _tabIndex = 0;
  PageController _pageController;

  double _appBarElevation = 4.0;
  double _historyOpacity = 0.0;
  String _currentData = '';
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
  void _registerBusEvent() => BusManager.bus
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
        _currentData = _historyDates[0];
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
}
