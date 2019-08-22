class PostModel {
  String name;
  String logoImage;
  String address;
  String message;
  String messageImage;
  int readCount;
  int likesCount;
  int commentsCount;
  String postTime;
  List<String> photos;
  bool isLike;

  PostModel({
    this.name,
    this.logoImage,
    this.address,
    this.message,
    this.messageImage,
    this.readCount,
    this.likesCount,
    this.commentsCount,
    this.postTime,
    this.photos,
    this.isLike
  });
}
