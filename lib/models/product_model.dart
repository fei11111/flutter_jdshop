class ProductModel {
  List<ProductItemModel> result;

  ProductModel({this.result});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      result: json['result'] != null
          ? json['result']
              .map<ProductItemModel>((v) => new ProductItemModel.fromJson(v))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductItemModel {
  String id;
  String title;
  String cid;
  Object price;
  String oldPrice;
  String pic;
  String sPic;

  ProductItemModel(
      {this.id,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.pic,
      this.sPic});

  factory ProductItemModel.fromJson(Map<String, dynamic> json) {
    return ProductItemModel(
      id: json['_id'],
      title: json['title'],
      cid: json['cid'],
      price: json['price'],
      oldPrice: json['old_price'],
      pic: json['pic'],
      sPic: json['s_pic'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['pic'] = this.pic;
    data['s_pic'] = this.sPic;
    return data;
  }
}
