import './gank_info.dart';
import '../constant/strings.dart';

class TodayInfo {
  final bool error;
  final String girlImage;
  final List<String> category;
  final Map<String, List<GankInfo>> itemData;

  TodayInfo({this.error, this.girlImage, this.category, this.itemData});

  factory TodayInfo.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> results = json['results'];
    Map<String, List<GankInfo>> itemData = {};
    String girlImage = '';
    results.forEach((key, value) {
      if (key == StringValues.CATEGORY_WELFARE) {
        girlImage = value[0]['url'];
      } else {
        itemData[key] = (value as List<dynamic>)
            ?.map((json) => GankInfo.fromJson(json))
            ?.toList();
      }
    });

    List<String> category =
        (json['category'] as List)?.map((name) => name.toString())?.toList();
    return TodayInfo(
        error: json['error'],
        girlImage: girlImage,
        category: category,
        itemData: itemData);
  }
}
