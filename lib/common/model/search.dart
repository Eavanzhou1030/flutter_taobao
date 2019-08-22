class SearchResultItemModal {
  String shopName;
  String wareName;
  String price;
  String coupon;
  String imageUrl;
  String commentcount;
  String good;
  String shopId;
  String disCount;

  SearchResultItemModal({
    this.shopName,
    this.wareName,
    this.price,
    this.coupon,
    this.imageUrl,
    this.commentcount,
    this.good,
    this.shopId,
    this.disCount
  });

  factory SearchResultItemModal.fromJson(dynamic json) {
    String picUrl = 'http://img10.360buyimg.com/mobilecms/s270x270_' + json['Content']['imageUrl'];
    String coupon;

    if(json['coupon'] != null) {
      if(json['coupon']['m'] != '0') {
        coupon = '满${json['coupon']['m']}件${json['pfdt']['j']}折';
      }
    }

    String disCount;
    if(json['pfdt'] != null) {
      if(json['pdft']['m'] != '') {
        disCount = '${json['pdft']['m']}件${json['pfdt']['j']}折';
      }
    }

    return SearchResultItemModal(
      shopId: json['shop_id'],
      shopName: json['shop_name'],
      imageUrl: picUrl,
      good: json['good'],
      commentcount: json['commentcount'],
      price: json['dredisprice'],
      coupon: coupon,
      disCount: disCount,
      wareName: json['Content']['warename']
    );
  }
}


class SearchResultListModal {
  List<SearchResultItemModal> data;

  SearchResultListModal(this.data);

  factory SearchResultListModal.fromJson(List json) {
    return SearchResultListModal(json.map((i) => SearchResultItemModal.fromJson(i)).toList());
  }
}
