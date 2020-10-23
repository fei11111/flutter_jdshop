class UserModel  {
	String id;
	String username;
	String tel;
	String salt;

	UserModel({this.id, this.username, this.tel, this.salt});

	factory UserModel.fromJson(Map<String, dynamic> json) {
		return UserModel(
			id: json['_id'],
			username: json['username'],
			tel: json['tel'],
			salt: json['salt'],
		);
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['_id'] = this.id;
		data['username'] = this.username;
		data['tel'] = this.tel;
		data['salt'] = this.salt;
		return data;
	}


}
