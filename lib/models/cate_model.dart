class CateModel {
  List<CateItemModel> result;

  CateModel({this.result});

  factory CateModel.fromJson(Map<String, dynamic> json) {
    return CateModel(
      result: json['result'] != null
          ? json['result']
              .map<CateItemModel>((v) => new CateItemModel.fromJson(v))
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

class CateItemModel {
  String id;
  String title;
  Object status;
  String pic;
  String pid;
  String sort;

  CateItemModel(
      {this.id, this.title, this.status, this.pic, this.pid, this.sort});

  factory CateItemModel.fromJson(Map<String, dynamic> json) {
    return CateItemModel(
      id: json['_id'],
      title: json['title'],
      status: json['status'],
      pic: json['pic'],
      pid: json['pid'],
      sort: json['sort'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['pid'] = this.pid;
    data['sort'] = this.sort;
    return data;
  }
}
