class CartInfoModeEntity {
  String images;
  String goodsId;
  double price;
  int count;
  String goodsName;
  double priceOriginal;
  bool isCheck;

  CartInfoModeEntity(
      {this.images,
      this.goodsId,
      this.price,
      this.count,
      this.goodsName,
      this.priceOriginal});

  CartInfoModeEntity.fromJson(Map<String, dynamic> json) {
    images = json['images'];
    goodsId = json['goodsId'];
    price = json['price'];
    count = json['count'];
    goodsName = json['goodsName'];
    isCheck = json['isCheck'];
    priceOriginal = json['priceOriginal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['images'] = this.images;
    data['goodsId'] = this.goodsId;
    data['price'] = this.price;
    data['count'] = this.count;
    data['goodsName'] = this.goodsName;
    data['priceOriginal'] = this.priceOriginal;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
