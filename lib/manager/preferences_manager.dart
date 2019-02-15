import 'package:shared_preferences/shared_preferences.dart';

class PreferencesManager {
  /// 目的是预加载？？？
  static Future<SharedPreferences> getInstance() async =>
      await SharedPreferences.getInstance();

}