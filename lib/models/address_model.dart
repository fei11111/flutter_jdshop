class AddressModel {
  bool success;
  String message;
  List<AddressItemModel> result;

  AddressModel({this.success, this.message, this.result});

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      success: json['success'],
      message: json['message'],
      result: json['result'] != null
          ? json['result']
              .map<AddressItemModel>((v) => new AddressItemModel.fromJson(v))
              .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class AddressItemModel {
  String id;
  String uid;
  String name;
  String phone;
  String address;
  int defaultAddress;
  int status;
  int addTime;

  AddressItemModel(
      {this.id,
      this.uid,
      this.name,
      this.phone,
      this.address,
      this.defaultAddress,
      this.status,
      this.addTime});

  factory AddressItemModel.fromJson(Map<String, dynamic> json) {
    return AddressItemModel(
      id: json['_id'],
      uid: json['uid'],
      name: json['name'],
      phone: json['phone'],
      address: json['address'],
      defaultAddress: json['default_address'],
      status: json['status'],
      addTime: json['add_time'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.id;
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['phone'] = this.phone;
    data['address'] = this.address;
    data['default_address'] = this.defaultAddress;
    data['status'] = this.status;
    data['add_time'] = this.addTime;
    return data;
  }
}
