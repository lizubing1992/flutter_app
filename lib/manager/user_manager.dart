import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../model/user_info.dart';
import '../manager/preferences_manager.dart';

class UserManager {
  static const String KEY_USER_INFO = 'key_user_info';

  ///用户是否登录
  static Future<bool> isLogin() async {
    SharedPreferences preferences = await PreferencesManager.getInstance();
    return preferences.get(KEY_USER_INFO) != null;
  }

  /// 保存用户信息
  /// [userInfo] 用户信息
  static Future<void> saveToLocal(UserInfo userInfo) async {
    String userInfoData = json.encode(userInfo.toJson());
    SharedPreferences preferences = await PreferencesManager.getInstance();
    await preferences.setString(KEY_USER_INFO, userInfoData);
  }

  /// 从本地删除用户信息
  static Future<bool> removeFromLocal() async {
    SharedPreferences preferences = await PreferencesManager.getInstance();
    return preferences.remove(KEY_USER_INFO);
  }

  /// 获取用户信息
  static Future<UserInfo> getUserInfo() async {
    SharedPreferences preferences = await PreferencesManager.getInstance();
    String userInfoData = preferences.getString(KEY_USER_INFO);
    UserInfo userInfo = UserInfo.fromJson(json.decode(userInfoData));
    return userInfo;
  }
}
