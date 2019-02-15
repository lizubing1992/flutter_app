import 'dart:io';
import 'package:objectdb/objectdb.dart';
import 'package:flutter_app/model/gank_info.dart';
import 'package:path_provider/path_provider.dart';

/// favor 数据库管理
class FavoriteManager {
  static ObjectDB db;

  static init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    final String path = '${directory.path}gank_favorites.db';
    db = new ObjectDB(path);
    await db.open();
  }

  static void close() async => await db.close();

  static insert(GankInfo gankInfo) async => await db.insert(gankInfo.toJson());

  ///根据itemId删除数据
  static delete(GankInfo gankInfo) async =>
      await db.remove({'itemId': gankInfo.itemId});

  static find(Map<dynamic,dynamic> query) async => await db.first(query);
}
