class Api {
  /// 发过干货日期接口
  static const String HISTORY = 'https://gank.io/api/day/history';

  /// 获取最新一天的干货
  static const String TODAY = 'http://gank.io/api/today';

  /// 获取所有的历史干货
  static const String HISTORY_CONTENT = 'http://gank.io/api/history/content';

  /// 获取某个日期的干货
  static const String SPECIAL_DAY = 'https://gank.io/api/day/';

  /// 获取分类数据
  static const String DATA = 'https://gank.io/api/data/';

  /// 查询
  static const String SEARCH = 'http://gank.io/api/search/';

  /// 提交新干货
  static const String SUBMIT = 'http://gank.io/api/add2gank';

  /// GitHub授权
  static const String AUTHORIZE = 'https://api.github.com/authorizations';

  /// 获取GitHub用户信息
  static const String USER_INFO = 'https://api.github.com/user';
}
