class FocusModel {
  List<FocusItemModel> result;

  FocusModel({this.result});

  factory FocusModel.fromJson(Map<String, dynamic> json) {
    return FocusModel(
      result: json['result'] != null
          ? json['result']
              .map<FocusItemModel>((v) => new FocusItemModel.fromJson(v))
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

class FocusItemModel {
  String id;
  String title;
  String status;
  String pic;
  String url;

  FocusItemModel({this.id, this.title, this.status, this.pic, this.url});

  factory FocusItemModel.fromJson(Map<String, dynamic> json) {
    return FocusItemModel(
      id: json['_id'],
      title: json['title'],
      status: json['status'],
      pic: json['pic'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['title'] = this.title;
    data['status'] = this.status;
    data['pic'] = this.pic;
    data['url'] = this.url;
    return data;
  }
}
