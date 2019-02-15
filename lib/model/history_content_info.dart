import '../util/time_util.dart';

/// 历史干货信息
class HistoryContentInfo {
  final String itemId;
  final String thumb;
  final String createdAt;
  final String publishedAt;
  final String randId;
  final String title;
  final String updatedAt;

  HistoryContentInfo(
      {this.itemId,
      this.thumb,
      this.createdAt,
      this.publishedAt,
      this.randId,
      this.title,
      this.updatedAt});

  factory HistoryContentInfo.fromJson(Map<String, dynamic> json) {
    RegExp exp = new RegExp(r'src=\"(.+?)\"');
    String thumb = exp.firstMatch(json['content']).group(1);
    if (thumb.contains('large')) {
      thumb = thumb.replaceFirst('large', 'mw690');
    }
    return HistoryContentInfo(
        itemId: json['_id'],
        thumb: thumb,
        createdAt: json['created_at'],
        publishedAt: formatDateStr(json['publishedAt']),
        randId: json['rand_id'],
        title: json['title'],
        updatedAt: json['updated_at']);
  }
}
