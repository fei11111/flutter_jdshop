import 'package:flutter/cupertino.dart';

class ProductDetailModel {
  ProductDetailItemModel result;

  ProductDetailModel({this.result});

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      result: json['result'] != null
          ? new ProductDetailItemModel.fromJson(json['result'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.result != null) {
      data['result'] = this.result.toJson();
    }
    return data;
  }
}

class Attr {
  String cate;
  List<String> list;
  List<Map> attrList;

  Attr({this.cate, this.list, this.attrList});

  factory Attr.fromJson(Map<String, dynamic> json) {
    return Attr(
        cate: json['cate'],
        list: json['list'].cast<String>(),
        attrList: json['attrList'] == null ? [] : json['attrList'].cast<Map>());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cate'] = this.cate;
    data['list'] = this.list;
    data['attrList'] = this.attrList;
    return data;
  }
}

class ProductDetailItemModel {
  String id;
  String title;
  String cid;
  Object price;
  String oldPrice;
  Object isBest;
  Object isHot;
  Object isNew;
  String status;
  String pic;
  String content;
  String cname;
  List<Attr> attr;
  String subTitle;
  Object salecount;

  //新增
  int count;
  String selectedAttr;
  bool checked;

  ProductDetailItemModel(
      {this.id,
      this.title,
      this.cid,
      this.price,
      this.oldPrice,
      this.isBest,
      this.isHot,
      this.isNew,
      this.status,
      this.pic,
      this.content,
      this.cname,
      this.attr,
      this.subTitle = "",
      this.salecount,
      this.count,
      this.selectedAttr,
      this.checked});

  factory ProductDetailItemModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailItemModel(
        id: json['_id'],
        title: json['title'],
        cid: json['cid'],
        price: json['price'],
        oldPrice: json['old_price'],
        isBest: json['is_best'],
        isHot: json['is_hot'],
        isNew: json['is_new'],
        status: json['status'],
        pic: json['pic'],
        content: json['content'],
        cname: json['cname'],
        attr: json['attr'] != null
            ? json['attr'].map<Attr>((v) => new Attr.fromJson(v)).toList()
            : null,
        subTitle: json['sub_title'],
        salecount: json['salecount'],
        count: json['count'] == null ? 1 : json['count'],
        selectedAttr: json['selectedAttr'] == null ? "" : json['selectedAttr'],
        checked: json['checked'] == null ? false : json['checked']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['cid'] = this.cid;
    data['price'] = this.price;
    data['old_price'] = this.oldPrice;
    data['is_best'] = this.isBest;
    data['is_hot'] = this.isHot;
    data['is_new'] = this.isNew;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['content'] = this.content;
    data['cname'] = this.cname;
    if (this.attr != null) {
      data['attr'] = this.attr.map((v) => v.toJson()).toList();
    }
    data['sub_title'] = this.subTitle;
    data['salecount'] = this.salecount;
    data['count'] = this.count;
    data['selectedAttr'] = this.selectedAttr;
    data['checked'] = this.checked;
    return data;
  }

  @override
  bool operator ==(other) {
    if (other is! ProductDetailItemModel) {
      return false;
    }
    final ProductDetailItemModel model = other;
    debugPrint("selectedAttr=$selectedAttr");
    debugPrint("selectedAttr=${model.selectedAttr}");
    return id == model.id && selectedAttr == model.selectedAttr;
  }

  @override
  int get hashCode => super.hashCode;
}
