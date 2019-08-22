class ImageModel {
  int width;
  int height;
  String thumb;

  ImageModel({
    this.height,
    this.width,
    this.thumb
  });

  // 序列化：将对象成员中的对象转化为字符串
  // 反序列化：将字符串转化为json对象
  // 将类成员对象转化为json对象
  ImageModel.fromJSON(dynamic json)
    : width = int.parse(json['width']),
      height = int.parse(json['height']),
      thumb = json['thumb'];
}