class KingKongItem {
  String href;
  String picUrl;
  String title;
  KingKongItem({this.href, this.picUrl, this.title});

  // fromJson 将Map转化为对象，toJson将对象转化为Map
  KingKongItem.fromJson(Map<String, dynamic> json)
    : href = json['href'],
      title = json['title'],
      picUrl = json['picUrl'];
}

class KingKongList {
  List<KingKongItem> items;
  KingKongList({this.items});

  factory KingKongList.fromJson(dynamic json) {
    List list = (json as List).map((i) {
      return KingKongItem.fromJson(i);
    }).toList();
    return KingKongList(items: list);
  }
}