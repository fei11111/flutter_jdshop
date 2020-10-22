class AddressModel {
  String id;
  String userName;
  String area;
  String detail;
  String tel;
  bool isDefault;

  AddressModel(
      {this.id,
      this.userName,
      this.area,
      this.detail,
      this.tel,
      this.isDefault});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['_id'],
      userName: json['userName'],
      area: json['area'],
      detail: json['detail'],
      tel: json['tel'],
      isDefault: json['isDefault'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['userName'] = this.userName;
    data['area'] = this.area;
    data['detail'] = this.detail;
    data['tel'] = this.tel;
    data['isDefault'] = this.isDefault;
    return data;
  }
}
