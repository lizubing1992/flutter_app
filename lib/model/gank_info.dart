class GankInfo {
  final String itemId;
  final String createdAt;
  final String desc;
  final List<String> images;
  final String publishedAt;
  final String source;
  final String type;
  final String url;
  final bool used;
  final String who;
  final bool isTitle;
  final String title;

  GankInfo(
      {this.itemId,
      this.createdAt,
      this.desc,
      this.images,
      this.publishedAt,
      this.source,
      this.type,
      this.url,
      this.used,
      this.who,
      this.isTitle = false,
      this.title});

  factory GankInfo.fromJson(Map<String, dynamic> json) => new GankInfo(
      itemId: json['itemId'] ?? json['_id'] ?? json['ganhuo_id'],
      createdAt: json['createdAt'],
      desc: json['desc'],
      images:
          (json['images'] as List)?.map((image) => image.toString())?.toList(),
      publishedAt: json['publishedAt'],
      source: json['source'],
      type: json['type'],
      url: json['url'],
      used: json['used'],
      who: json['who']);

  Map<String, dynamic> toJson() => {
        'itemId': this.itemId,
        'createdAt': this.createdAt,
        'desc': this.desc,
        'images': this.images,
        'publishedAt': this.publishedAt,
        'source': this.source,
        'type': this.type,
        'url': this.url,
        'used': this.used,
        'who': this.type
      };
}
